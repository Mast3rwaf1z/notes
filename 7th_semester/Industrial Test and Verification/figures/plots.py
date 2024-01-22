import matplotlib.pyplot as plt
import os

ax:plt.Axes # syntax highlighting

os.system("mkdir -p .cache")

# First plot

fig, ax = plt.subplots()

ax.set_xlim(left=0.5, right=2.5)
ax.set_ylim(bottom=0.5, top=2.5)
ax.set_xlabel("$x_1$")
ax.set_ylabel("$x_2$")
ax.set_yticks([1, 2], ["c", "d"])
ax.set_xticks([1, 2], ["a", "b"])
ax.plot([0, 3], [1, 1], "--", color="gray")
ax.plot([0, 3], [2, 2], "--", color="gray")
ax.plot([1, 1], [0, 3], "--", color="gray")
ax.plot([2, 2], [0, 3], "--", color="gray")
ax.plot([1.1, 1, 0.9], [1.5, 1.5, 1.5], 'o', color="black")
ax.plot([1.5, 1.5, 1.5], [1.1, 1, 0.9], 'o', color="black")
ax.plot([2.1, 2, 1.9], [1.5, 1.5, 1.5], 'o', color="black")
ax.plot([1.5, 1.5, 1.5], [2.1, 2, 1.9], 'o', color="black")
ax.plot([1.1, 1.1, 1.1], [2.1, 2, 1.9], 'o', color="black")
ax.plot([1, 1, 1],       [2.1, 2, 1.9], 'o', color="black")
ax.plot([0.9, 0.9, 0.9], [2.1, 2, 1.9], 'o', color="black")
ax.plot([2.1, 2.1, 2.1], [2.1, 2, 1.9], 'o', color="black")
ax.plot([2, 2, 2],       [2.1, 2, 1.9], 'o', color="black")
ax.plot([1.9, 1.9, 1.9], [2.1, 2, 1.9], 'o', color="black")
ax.plot([1.1, 1.1, 1.1], [1.1, 1, 0.9], 'o', color="black")
ax.plot([1, 1, 1],       [1.1, 1, 0.9], 'o', color="black")
ax.plot([0.9, 0.9, 0.9], [1.1, 1, 0.9], 'o', color="black")
ax.plot([2.1, 2.1, 2.1], [1.1, 1, 0.9], 'o', color="black")
ax.plot([2, 2, 2],       [1.1, 1, 0.9], 'o', color="black")
ax.plot([1.9, 1.9, 1.9], [1.1, 1, 0.9], 'o', color="black")
ax.plot(1.5, 1.5, 'o', color="black")
plt.savefig(".cache/Boundary_Values.pdf")