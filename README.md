# Base de Dados 2026/2027 — Ambiente SQL Server

Everything you need for the practical classes runs inside a **GitHub Codespace**.
Nothing is installed on your own machine, and it works identically on Windows,
macOS and Linux.

Two databases are created for you automatically:

| Database | Schemas | Content |
|---|---|---|
| `ULHT_DB26` | `HR`, `Scott` | Classic HR / Scott teaching schemas — 11 tables, 10 foreign keys |
| `BikeStores` | `production`, `sales` | Larger sample database, ~9 000 rows |

---

## 1. Get your own copy of the repository

**Do this before anything else.** You need your *own* repository — working
directly in the class repository is not possible and your work would be lost.

**If you have a GitHub Classroom link:** click it, accept the assignment, and GitHub creates a private repository for you automatically. <br>
Skip to step 2 — the link takes you to your new repository.

**Otherwise:** open the class repository, click the green **Use this template**
button → **Create a new repository**. Give it a meaningful name (e.g. `db26-<yourname>`)
and create it. <br>You now own a full copy of the classroom environment in your own repository.

> Do **not** use Fork, and do not create a codespace directly on the class repository. <br>
> Both leave your work somewhere you cannot properly commit to.

Everything below happens in **your** repository, not the class one.

---

## 2. Start the environment

Click **Code → Codespaces → Create codespace on main**.

First launch should take **up to 5 minutes** while the SQL Server image is pulled and the seed scripts run (seed scripts are responsible for creating and populating the class databases). <br>
The SQL Server extension in the sidebar may take a little longer still to finish loading. Database connections **won't work until extensions are fully loaded**, so you can take this time to check all environment files are available and read through the README, it will be very useful during the semester.

Setup runs in the background, **not** in the terminal, so an empty terminal does not mean nothing is happening.<br>
To watch setup running, open the Command Palette
(`F1` or `Ctrl+Shift+P`) and run **Codespaces: View Creation Log**.<br>
When you see `Seed complete` in the last lines, both databases are ready.

You only do this **once for the whole semester.**
<br>After completing environment setup, you can close the browser tab and return to class codespace whenever you like — the codespace stops on its own and resumes in about
30 seconds with all your work intact... kind of!

> A codespace that goes untouched for 30 days is deleted by GitHub, along with anything you never pushed.<br>
> So **COMMIT OFTEN**. Do it at the end of each class and any time you make significant changes to your work.<br>
 
Commit in codespace, then push to your GitHub repository.<br> It's important to note that the codespace is not a backup, it is just a convenient place to work. Your GitHub repository is your backup.<br>

When using GitHub Classroom, you can also use the **Submit** button to push your work to the class repository for grading.

---

## 3. Query from inside the codespace

**Database connections**
| Field | Value |
|---|---|
| Login | `sa` |
| Default Password | Ulht#db26!Class |

> **Note:** The default password can be changed after the initial setup, from within the SQL Server management tools.

**Option A — the SQL Server panel.** Click the database icon in the left sidebar. Two connections are pre-configured. Pick one, paste the SA password
when prompted, and you get a query editor with IntelliSense.

code examples:
```sql
USE ULHT_DB26;
SELECT TOP 5 * FROM HR.EMPLOYEES;
```

**Option B — the terminal.**
If you don't have the Terminal open, open it with **Terminal → New Terminal**. Then run:
```bash
sql                       # interactive session
sql -d BikeStores         # against a specific database
sql -Q "SELECT TOP 5 * FROM HR.EMPLOYEES"
sql -i exercises/aula03.sql
```
---

## 6. FolderLayout

```

├─── .devcontainer
│    ├─── devcontainer.json      Codespaces config: extensions, ports, machine size
│    ├─── docker-compose.yml     the two containers (workspace + db)
│    ├─── postCreate.sh          one-time setup, runs the seed
│    └─── postStart.sh           re-seeds if the volume was lost
└─── .github
│    └─── workflows
│         └─── build-image.yml   GitHub Actions workflow to build the SQL Server image
├─── db
│    ├─── init/                  the seed scripts, in execution order
│    ├─── data/                  CSV/JSON files for BULK INSERT exercises
│    ├─── seed.sh                runs files in init folder in order, stops on first error
│    └─── reset.sh               drop + re-seed
├─── exercises                   your work goes here
└─── image
     └─── Dockerfile             the SQL Server base image (built by CI, not by you)
```

### A note on `db/data/`
When deploying each instance, codespaces creates a **named volume** for the SQL Server container. That volume is mounted at `/db/data` inside the container, and is **persistent** across codespace restarts.<br>
Files placed there are visible **inside the SQL Server container** at `/db/data`.
That matters because `BULK INSERT` and `OPENROWSET` read files server-side, not
from wherever you happen to be typing:

```sql
-- Load data example:
-- To load `orders.csv` into the `sales.staging` table, run this query in the SQL panel or terminal:

BULK INSERT sales.staging
FROM '/db/data/orders.csv'
WITH (FORMAT='CSV', FIRSTROW=2, CODEPAGE='65001');

-- File 'orders.csv' must be inside `/db/data` folder in your repository. Upload it from your PC if required.<br>
-- Path is **inside the SQL Server container**, not your local machine.
-- CODEPAGE refers to the encoding of the file. 65001 means UTF-8 with Latin characters (Portuguese accents). Change code if using a different encoding characters.
```

---

## 5. What if something goes wrong...
... and it *will*. That is what a sandbox is for!

Run the command below in the terminal to drop and rebuild both databases from scratch.
```bash
db-reset
```

Drops both databases and rebuilds them from `db/init/`. Takes about a minute.
> Be aware that this **destroys all your work** in those databases.<br>
> Anything you created inside those databases is gone — so keep all your exercise scripts in `exercises/`, not only in the server.

To reset just one database, or to see exactly what is being run, look at
`db/seed.sh`.<br>
The seed scripts are plain SQL and you are encouraged to read them <br>
You might want to wait for the class when each script is explained to better understand how it works, but it is also valid to explore them now to get a grasp on how real SQL code looks like and what is being done to set the environment.

> **WARNING: Do not edit any script**<br>
> They are re-run every time the environment is reset. Any change can break the environment for everyone, and you will have to fix it yourself or face severe consequences in your grade...

---

## Troubleshooting

**The SQL panel says "login failed for user sa"** — first check whether the
databases actually exist. The full message is often *"Cannot open database
ULHT_DB26 requested by the login. The login failed."*, which looks like a
password problem but means the database is missing, i.e. setup did not finish.

Open the Command Palette (`F1`) → **Codespaces: View Creation Log** and look
for `Seed complete` at the end. If it is not there, re-run setup in a terminal
and watch it:

```bash
bash .devcontainer/postCreate.sh
```

If the databases do exist and the login still fails, the password really is
wrong — it is the class password, not your GitHub password.

**`db-reset` hangs** — you have an open transaction in another query window.
The script forces sessions off, but a stuck editor can still hold on; reload
the window and retry.

**`gh codespace ports forward` says the port is already in use** — you have a
local SQL Server on 1433. Forward to a different local port:
`gh codespace ports forward 5433:1433`, then connect to `localhost,5433`.

**Everything is broken and I do not know why** — from the Codespaces page on
GitHub, delete the codespace and create a new one. Push your work first.
