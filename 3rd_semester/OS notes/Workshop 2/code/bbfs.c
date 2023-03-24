/*
  Big Brother File System
*/

#define HAVE_SYS_XATTR_H 1

#include "params.h"

#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <fuse.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#ifdef HAVE_SYS_XATTR_H
#include <sys/xattr.h>
#endif

#include "log.h"

//  All the paths are relative to the root of the mounted
//  filesystem.
static void bb_fullpath(char fpath[PATH_MAX], const char *path) {
  strcpy(fpath, BB_DATA->rootdir);
  strncat(fpath, path, PATH_MAX); // ridiculously long paths will
  log_msg("    bb_fullpath:  rootdir = \"%s\", path = \"%s\", fpath = \"%s\"\n", BB_DATA->rootdir, path, fpath);
}

/**
 * Get file attributes.
 */
int bb_getattr(const char *path, struct stat *statbuf) {
  int retstat;
  char fpath[PATH_MAX];

  //log_command("bb_getattr(path=\"%s\", statbuf=0x%08x)", path, statbuf);

  bb_fullpath(fpath, path);

  retstat = log_syscall("lstat", lstat(fpath, statbuf), 0);

  log_stat(statbuf);

  return retstat;
}

/**
 * Read the target of a symbolic link
 */
int bb_readlink(const char *path, char *link, size_t size) {
  int retstat;
  char fpath[PATH_MAX];

  //log_msg("bb_readlink(path=\"%s\", link=\"%s\", size=%d)", path, link, size);
  bb_fullpath(fpath, path);

  retstat = log_syscall("fpath", readlink(fpath, link, size - 1), 0);
  if (retstat >= 0) {
    link[retstat] = '\0';
    retstat = 0;
  }

  return retstat;
}

/**
 * Create a file node
 */
int bb_mknod(const char *path, mode_t mode, dev_t dev) {
  int retstat;
  char fpath[PATH_MAX];

  log_command("bb_mknod(path=\"%s\", mode=0%3o, dev=%lld)", path, mode, dev);
  bb_fullpath(fpath, path);
  if (S_ISREG(mode)) {
    retstat = log_syscall("open", open(fpath, O_CREAT | O_EXCL | O_WRONLY, mode), 0);
    if (retstat >= 0) {
      retstat = log_syscall("close", close(retstat), 0);
    }
  } else if (S_ISFIFO(mode)) {
    retstat = log_syscall("mkfifo", mkfifo(fpath, mode), 0);
  } else {
    retstat = log_syscall("mknod", mknod(fpath, mode, dev), 0);
  }

  return retstat;
}

/**
 * Create a directory
 */
int bb_mkdir(const char *path, mode_t mode) {
  char fpath[PATH_MAX];

  log_command("bb_mkdir(path=\"%s\", mode=0%3o)", path, mode);
  bb_fullpath(fpath, path);

  return log_syscall("mkdir", mkdir(fpath, mode), 0);
}

/**
 * Remove a file
 */
int bb_unlink(const char *path) {
  char fpath[PATH_MAX];

  log_command("bb_unlink(path=\"%s\")", path);
  bb_fullpath(fpath, path);

  return log_syscall("unlink", unlink(fpath), 0);
}

/**
 * Remove a directory
 */
int bb_rmdir(const char *path) {
  char fpath[PATH_MAX];

  log_command("bb_rmdir(path=\"%s\")", path);
  bb_fullpath(fpath, path);

  return log_syscall("rmdir", rmdir(fpath), 0);
}

/**
 * Create a symbolic link
 */
int bb_symlink(const char *path, const char *link) {
  char flink[PATH_MAX];

  //log_command("bb_symlink(path=\"%s\", link=\"%s\")", path, link);
  bb_fullpath(flink, link);

  return log_syscall("symlink", symlink(path, flink), 0);
}

/**
 * Rename a file
 */
int bb_rename(const char *path, const char *newpath) {
  char fpath[PATH_MAX];
  char fnewpath[PATH_MAX];

  log_command("bb_rename(fpath=\"%s\", newpath=\"%s\")", path, newpath);
  bb_fullpath(fpath, path);
  bb_fullpath(fnewpath, newpath);

  return log_syscall("rename", rename(fpath, fnewpath), 0);
}

/**
 * Create a hard link to a file
 */
int bb_link(const char *path, const char *newpath) {
  char fpath[PATH_MAX], fnewpath[PATH_MAX];

  //log_command("bb_link(path=\"%s\", newpath=\"%s\")", path, newpath);
  bb_fullpath(fpath, path);
  bb_fullpath(fnewpath, newpath);

  return log_syscall("link", link(fpath, fnewpath), 0);
}

/**
 * Change the permission bits of a file
 */
int bb_chmod(const char *path, mode_t mode) {
  char fpath[PATH_MAX];

  //log_command("bb_chmod(fpath=\"%s\", mode=0%03o)", path, mode);
  bb_fullpath(fpath, path);

  return log_syscall("chmod", chmod(fpath, mode), 0);
}

/**
 * Change the owner and group of a file
 */
int bb_chown(const char *path, uid_t uid, gid_t gid) {
  char fpath[PATH_MAX];

  //log_command("bb_chown(path=\"%s\", uid=%d, gid=%d)", path, uid, gid);
  bb_fullpath(fpath, path);

  return log_syscall("chown", chown(fpath, uid, gid), 0);
}

/**
 * Change the size of a file
 */
int bb_truncate(const char *path, off_t newsize) {
  char fpath[PATH_MAX];

  //log_command("bb_truncate(path=\"%s\", newsize=%lld)", path, newsize);
  bb_fullpath(fpath, path);

  return log_syscall("truncate", truncate(fpath, newsize), 0);
}

/**
 * Change the access and/or modification times of a file
 */
int bb_utime(const char *path, struct utimbuf *ubuf) {
  char fpath[PATH_MAX];

  //log_command("bb_utime(path=\"%s\", ubuf=0x%08x)", path, ubuf);
  bb_fullpath(fpath, path);

  return log_syscall("utime", utime(fpath, ubuf), 0);
}

/**
 * File open operation
 */
int bb_open(const char *path, struct fuse_file_info *fi) {
  int retstat = 0;
  int fd;
  char fpath[PATH_MAX];

  log_command("Open(path\"%s\", fi=0x%08x)", path, fi);
  bb_fullpath(fpath, path);

  fd = log_syscall("open", open(fpath, fi->flags), 0);
  if (fd < 0) {
    retstat = log_error("open");
  }

  fi->fh = fd;

  log_fi(fi);

  return retstat;
}

/**
 * Read data from an open file
 */
int bb_read(const char *path, char *buf, size_t size, off_t offset, struct fuse_file_info *fi) {
  if (offset == 0){
    log_command("Read(path=\"%s\", buf=0x%08x, size=%d, offset=%lld, fi=0x%08x)", path, buf, size, offset, fi);  
  }
  log_fi(fi);

  return log_syscall("pread", pread(fi->fh, buf, size, offset), 0);
}

/**
 * Write data to an open file
 */
int bb_write(const char *path, const char *buf, size_t size, off_t offset, struct fuse_file_info *fi) {
  log_command("Write(path=\"%s\", buf=0x%08x, size=%d, offset=%lld, fi=0x%08x)", path, buf, size, offset, fi);
  

  log_fi(fi);

  return log_syscall("pwrite", pwrite(fi->fh, buf, size, offset), 0);
}

/**
 * Get file system statistics
 */
int bb_statfs(const char *path, struct statvfs *statv)
{
  int retstat = 0;
  char fpath[PATH_MAX];

  log_command("bb_statfs(path=\"%s\", statv=0x%08x)", path, statv);
  bb_fullpath(fpath, path);

  // get stats for underlying filesystem
  retstat = log_syscall("statvfs", statvfs(fpath, statv), 0);

  log_statvfs(statv);

  return retstat;
}

/**
 * Possibly flush cached data
 */
int bb_flush(const char *path, struct fuse_file_info *fi) {
  //log_command("bb_flush(path=\"%s\", fi=0x%08x)", path, fi);
  log_fi(fi);

  return 0;
}

/**
 * Release an open file
 */
int bb_release(const char *path, struct fuse_file_info *fi) {
  //log_command("bb_release(path=\"%s\", fi=0x%08x)", path, fi);
  log_fi(fi);

  return log_syscall("close", close(fi->fh), 0);
}

/**
 * Synchronize file contents
 */
int bb_fsync(const char *path, int datasync, struct fuse_file_info *fi) {
  log_command("bb_fsync(path=\"%s\", datasync=%d, fi=0x%08x)", path, datasync, fi);
  log_fi(fi);

  // some unix-like systems (notably freebsd) don't have a datasync call
#ifdef HAVE_FDATASYNC
  if (datasync)
      return log_syscall("fdatasync", fdatasync(fi->fh), 0);
    else
#endif
  return log_syscall("fsync", fsync(fi->fh), 0);
}

#ifdef HAVE_SYS_XATTR_H
/** Set extended attributes */
int bb_setxattr(const char *path, const char *name, const char *value, size_t size, int flags) {
  char fpath[PATH_MAX];

  log_command("bb_setxattr(path=\"%s\", name=\"%s\", value=\"%s\", size=%d, flags=0x%08x)", path, name, value, size,
              flags);
  bb_fullpath(fpath, path);

  return log_syscall("lsetxattr", lsetxattr(fpath, name, value, size, flags), 0);
}

/**
 * Get extended attributes
 */
int bb_getxattr(const char *path, const char *name, char *value, size_t size) {
  int retstat = 0;
  char fpath[PATH_MAX];

  //log_command("bb_getxattr(path=\"%s\", name=\"%s\", value=0x%08x, size=%d)", path, name, value, size);
  bb_fullpath(fpath, path);

  retstat = log_syscall("lgetxattr", lgetxattr(fpath, name, value, size), 0);
  if (retstat >= 0) {
    log_msg("    value = \"%s\"\n", value);
  }

  return retstat;
}

/**
 * List extended attributes
 */
int bb_listxattr(const char *path, char *list, size_t size) {
  int retstat = 0;
  char fpath[PATH_MAX];
  char *ptr;

  log_command("bb_listxattr(path=\"%s\", list=0x%08x, size=%d)", path, list, size);
  bb_fullpath(fpath, path);

  retstat = log_syscall("llistxattr", llistxattr(fpath, list, size), 0);
  if (retstat >= 0) {
    log_msg("    returned attributes (length %d):\n", retstat);
    for (ptr = list; ptr < list + retstat; ptr += strlen(ptr)+1) {
      log_msg("    \"%s\"\n", ptr);
    }
  }

  return retstat;
}

/**
 * Remove extended attributes
 */
int bb_removexattr(const char *path, const char *name) {
  char fpath[PATH_MAX];

  log_command("bb_removexattr(path=\"%s\", name=\"%s\")", path, name);
  bb_fullpath(fpath, path);

  return log_syscall("lremovexattr", lremovexattr(fpath, name), 0);
}
#endif

/**
 * Open directory
 */
int bb_opendir(const char *path, struct fuse_file_info *fi) {
  DIR *dp;
  int retstat = 0;
  char fpath[PATH_MAX];

  log_command("bb_opendir(path=\"%s\", fi=0x%08x)", path, fi);
  bb_fullpath(fpath, path);

  dp = opendir(fpath);
  log_msg("    opendir returned 0x%p\n", dp);
  if (dp == NULL) {
    retstat = log_error("bb_opendir opendir");
  }

  fi->fh = (intptr_t) dp;

  log_fi(fi);

  return retstat;
}

/**
 * Read directory
 */

int bb_readdir(const char *path, void *buf, fuse_fill_dir_t filler, off_t offset, struct fuse_file_info *fi) {
  int retstat = 0;
  DIR *dp;
  struct dirent *de;

  //log_command("bb_readdir(path=\"%s\", buf=0x%08x, filler=0x%08x, offset=%lld, fi=0x%08x)", path, buf, filler, offset, fi);
  // once again, no need for fullpath -- but note that I need to cast fi->fh
  dp = (DIR *) (uintptr_t) fi->fh;

  de = readdir(dp);
  log_msg("    readdir returned 0x%p\n", de);
  if (de == 0) {
    retstat = log_error("bb_readdir readdir");
    return retstat;
  }

  do {
    if (filler(buf, de->d_name, NULL, 0) != 0) {
      log_msg("    ERROR bb_readdir filler:  buffer full");
      return -ENOMEM;
    }
  } while ((de = readdir(dp)) != NULL);

  log_fi(fi);

  return retstat;
}

/**
 * Release directory
 */
int bb_releasedir(const char *path, struct fuse_file_info *fi) {
  int retstat = 0;

  //log_command("bb_releasedir(path=\"%s\", fi=0x%08x)", path, fi);
  log_fi(fi);

  closedir((DIR *) (uintptr_t) fi->fh);

  return retstat;
}

/**
 * Synchronize directory contents
 */
int bb_fsyncdir(const char *path, int datasync, struct fuse_file_info *fi) {
  int retstat = 0;

  log_command("bb_fsyncdir(path=\"%s\", datasync=%d, fi=0x%08x)", path, datasync, fi);
  log_fi(fi);

  return retstat;
}

/**
 * Initialize filesystem
 *
 * The return value will passed in the private_data field of
 * fuse_context to all file operations and as a parameter to the
 * destroy() method.
 */
void *bb_init(struct fuse_conn_info *conn) {
  log_command("bb_init()");

  log_conn(conn);
  log_fuse_context(fuse_get_context());

  return BB_DATA;
}

/**
 * Clean up filesystem
 *
 * Called on filesystem exit.
 */
void bb_destroy(void *userdata) {
  log_command("bb_destroy(userdata=0x%08x)\n", userdata);
}

/** Check file access permissions */
int bb_access(const char *path, int mask) {
  int retstat = 0;
  char fpath[PATH_MAX];

  //log_command("bb_access(path=\"%s\", mask=0%o)", path, mask);
  bb_fullpath(fpath, path);

  retstat = access(fpath, mask);

  if (retstat < 0) {
    retstat = log_error("bb_access access");
  }

  return retstat;
}

/**
 * Create and open a file
 */
// Not implemented.

/**
 * Change the size of an open file
 */
int bb_ftruncate(const char *path, off_t offset, struct fuse_file_info *fi) {
  int retstat = 0;

  log_command("bb_ftruncate(path=\"%s\", offset=%lld, fi=0x%08x)", path, offset, fi);
  log_fi(fi);

  retstat = ftruncate(fi->fh, offset);
  if (retstat < 0) {
    retstat = log_error("bb_ftruncate ftruncate");
  }

  return retstat;
}

/**
 * Get attributes from an open file
 */
int bb_fgetattr(const char *path, struct stat *statbuf, struct fuse_file_info *fi) {
  int retstat = 0;

  log_command("bb_fgetattr(path=\"%s\", statbuf=0x%08x, fi=0x%08x)", path, statbuf, fi);
  log_fi(fi);
  if (!strcmp(path, "/")) {
    return bb_getattr(path, statbuf);
  }

  retstat = fstat(fi->fh, statbuf);
  if (retstat < 0) {
    retstat = log_error("bb_fgetattr fstat");
  }

  log_stat(statbuf);

  return retstat;
}

struct fuse_operations bb_oper = {
    .getattr = bb_getattr,
    .readlink = bb_readlink,
    .getdir = NULL,
    .mknod = bb_mknod,
    .mkdir = bb_mkdir,
    .unlink = bb_unlink,
    .rmdir = bb_rmdir,
    .symlink = bb_symlink,
    .rename = bb_rename,
    .link = bb_link,
    .chmod = bb_chmod,
    .chown = bb_chown,
    .truncate = bb_truncate,
    .utime = bb_utime,
    .open = bb_open,
    .read = bb_read,
    .write = bb_write,
    .statfs = bb_statfs,
    .flush = bb_flush,
    .release = bb_release,
    .fsync = bb_fsync,

#ifdef HAVE_SYS_XATTR_H
    .setxattr = bb_setxattr,
    .getxattr = bb_getxattr,
    .listxattr = bb_listxattr,
    .removexattr = bb_removexattr,
#endif

    .opendir = bb_opendir,
    .readdir = bb_readdir,
    .releasedir = bb_releasedir,
    .fsyncdir = bb_fsyncdir,
    .init = bb_init,
    .destroy = bb_destroy,
    .access = bb_access,
    .ftruncate = bb_ftruncate,
    .fgetattr = bb_fgetattr
};

void bb_usage() {
  fprintf(stderr, "usage:  bbfs [FUSE and mount options] rootDir mountPoint logFile\n");
  abort();
}

int main(int argc, char *argv[]) {
  int fuse_stat;
  struct bb_state *bb_data;
  if ((getuid() == 0) || (geteuid() == 0)) {
    fprintf(stderr, "Please do not run bb as root\n");
    return 1;
  }

  fprintf(stderr, "Fuse library version %d.%d\n", FUSE_MAJOR_VERSION, FUSE_MINOR_VERSION);

  if ((argc < 4) || (argv[argc - 3][0] == '-') || (argv[argc - 2][0] == '-') || (argv[argc - 1][0] == '-')) {
    bb_usage();
  }

  bb_data = malloc(sizeof(struct bb_state));
  if (bb_data == NULL) {
    perror("main calloc");
    abort();
  }

  char *logFile = argv[argc - 1];
  argv[argc - 1] = NULL;
  bb_data->rootdir = realpath(argv[argc - 3], NULL);
  argv[argc - 3] = argv[argc - 2];
  argv[argc - 2] = NULL;
  argc -= 2;

  bb_data->logfile = log_open(logFile);

  fprintf(stderr, "about to call fuse_main\n");
  fuse_stat = fuse_main(argc, argv, &bb_oper, bb_data);
  fprintf(stderr, "fuse_main returned %d\n", fuse_stat);

  free(bb_data);
  return fuse_stat;
}
