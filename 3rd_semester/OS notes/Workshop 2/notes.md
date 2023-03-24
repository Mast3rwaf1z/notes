# Workshop 2 presentation
*   Fuse filesystem
    *   et filsystem du kan mounte og arbejde på.
    *   når vi siger et filsystem refererer vi generelt til et linux filsystem
    *   fuse består af libfuse hvilket står som et kernel module, det betyder at det optræder som en bro mellem filsystemer og kernels
    *   vi har implementeret et big brother filsystem, det refererer til overvågning som man nok har hørt om før
        *   det er ret simpelt, alle systemkald er logget til en log fil når det er eksekveret i det her filsystem
        *   i det her case så har vi programmet fra workshop 1, her bliver der sendt data gennem en pipe fra et program til et andet der kører to threads, en der læser fra pipe og gemmer data, og en der læser fra data og gemmer det på disk
            *   de systemkald der bliver brugt her er typisk reads, writes, open og close
*   Device drivers
    *   typisk kernel moduler
        *   kan også bygges direkte ind i kernel
    *   der er forskel på en driver og et kernel modul, en driver er oftest også et kernel modul men ikke omvendt
    *   et kernel modul kan også være som set i den første opgave, et lag mellem et filsystem og kernel
    *   hvad er en kernel så? en kernel er et stort stykke eksekverbart kode der i linux' tilfælde er selve linux, så når man har sin distribution (ubuntu, mint, arch, gentoo eller andre) så er der altid en eller anden form for linux kernel bagved, de kommer i mange former:
        *   arm kernels, de er typisk bygget til den enkelte CPU model
        *   x86 og x86_64 kernels, de er meget mere generelle og kernel virker typisk altid på cpu'en så længe arkitektur passer
    *   der findes libraries i C til at initialisere moduler/drivers, driveren kan i sig selv godt bare være et print statement, det vigtige er hvor koden er defineret for kernel