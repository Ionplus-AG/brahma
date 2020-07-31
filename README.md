# Brahma

![Test status](https://ci.appveyor.com/api/projects/status/github/Ionplus-AG/brahma?svg=true)

Brahma is the database for preparing measurements, storing and analyzing results in the context of accelerated mass spectrometry (AMS). It is the central part of a laboratory information management system (LIMS).

## Running the tests

This repository provides a collection of tests, testing the structure and functionality of the brahma database. The tests are written in Python and run against a MySQL or MariaDB instance.

### Prerequisites

#### Database

For running the tests a MySQL (=5.7) or MariaDB (>=10.5) is required. You will need a database user with ''ALL PRIVILEGES''.

If the database isn't installed on the host running the tests, matching binaries have to be downloaded installed from https://downloads.mysql.com/archives/community/

To check if your installation is fine, run the following commands and enter the credentials accordingly:

```powershell
PS > mysql --user <username> -p --host <database-host>
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 76
Server version: 5.5.5-10.5.4-MariaDB-1:10.5.4+maria~focal mariadb.org binary distribution

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> exit
```

#### Python

Running the tests require Python (>=3.7) and some additional packages.

To install the required packages, open a shell in the root directory of brahma and run the following commands:

```powershell
PS ...\brahma> pip install pipenv
PS ...\brahma> pipenv sync
```

#### Test configuration

For running the tests, a test configuration file ''pytest.ini'' is required. You will find an example in the repository (''example_pytest.ini''). Take a copy of this file, name it ''pytest.ini'' and place it into the repositories root. Edit its content with a text editor of your choice:

```ini
[pytest]
#mysql_host = localhost
#mysql_user = root
mysql_password = <password>
#mysql_database_name = brahma_test
```

### Run the tests
After all prerequisites are met, the tests are run on the command line in the root directory of the brahma repository:

```powershell
PS ...\brahma> pipenv run py.test --capture=tee-sys
```

Copyright (c) 2020 Ionplus AG
