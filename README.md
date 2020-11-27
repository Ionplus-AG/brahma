# Brahma

![Test status](https://ci.appveyor.com/api/projects/status/github/Ionplus-AG/brahma?svg=true)

Brahma is the database for preparing measurements, storing and analyzing results in the context of accelerated mass spectrometry (AMS). It is the central part of a laboratory information management system (LIMS).

## Prerequisites

### Database

Brahma requires MySQL (>=8.0) or MariaDB (>=10.3). For working with brahma-cli or running the tests, a database user with ''ALL PRIVILEGES'' is needed.

If the database isn't installed on the host running the tests, matching binaries have to be downloaded installed from https://downloads.mysql.com/archives/community/. Ensure the command line tool ''mysql'' is included in your environments path.

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

### Python

brahma-cli and the tests require Python (>=3.7) and some additional packages.

To install the required packages, open a shell in the root directory of brahma and run the following commands:

```powershell
PS ...\brahma> pip install pipenv
PS ...\brahma> pipenv sync
```

## brahma-cli

brahma-cli makes it easy to create instances of brahma and to migrate existing legacy to brahma. Run it on a command line in the root directory of the brahma repository:

```powershell
PS ...\brahma> pipenv shell
PS ...\brahma> brahma-cli.py --help

Usage: brahma-cli.py [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  init          Initialize the brahma database schema.
  migrate-ac14  Migrate an ac14 database into brahma.
  migrate-ams   Migrate an ams database into brahma.
```

To get the help for a specific command, type:

```powershell
PS ...\brahma> pipenv shell
PS ...\brahma> brahma-cli.py init --help

Usage: brahma-cli.py init [OPTIONS] SCHEMA_NAME

  Initialize the brahma database schema.

  SCHEMA_NAME: the name for the brahma database schema

Options:
  --rebuild            drops and rebuilds existing brahma instance
  -p, --password TEXT  the database password
  --user TEXT          the database user  [default: root]
  --host TEXT          the database host  [default: localhost]
  --help               Show this message and exit.
```


## Running the tests

This repository provides a collection of tests. These are testing the structure and functionality of the brahma database. The tests are written in Python and run against a MySQL or MariaDB instance.

### Configuration

For running the tests, a test configuration file ''pytest.ini'' is required. You will find an example in the repository (''example_pytest.ini''). Take a copy of this file, name it ''pytest.ini'' and place it into the repositories root. Edit its content with a text editor of your choice:

```ini
[pytest]
#mysql_host = localhost
#mysql_user = root
mysql_password = <password>
#mysql_database_name = brahma_test
```

### Run the tests
After all prerequisites are met, the tests are run on a command line in the root directory of the brahma repository:

```powershell
PS ...\brahma> pipenv run py.test --capture=tee-sys
```

Copyright (c) 2020 Ionplus AG
