# Using Docker 🐳

To locally run the server, you'll need to use the [Docker](https://www.docker.com/) virtualization software.

## Install Docker

To install Docker, follow the instructions on the "[Install Docker Desktop on Mac](https://docs.docker.com/desktop/install/mac-install/)" docs page.
You **must** use the default settings in order to allow binding to `localhost:80`, etc.

## Install Appwrite Server

To install Appwrite using Docker, run the following command,
substituting `1.4.9` with the newest Appwrite Server version supported by the Appwrite SDK currently in use:

```sh
docker run -it --rm --volume /var/run/docker.sock:/var/run/docker.sock --volume "$(pwd)"/appwrite:/usr/src/code/appwrite:rw --entrypoint="install" appwrite/appwrite:1.4.9
```

## Create a new Appwrite Project

> **Note:**
> Eventually, we'll need to write a script to automate this.

1. Navigate to [`localhost:80/login`](http://localhost/login)
1. Click the sign up button.
   1. You'll want to remember your password somewhere.
1. Create a new project
   1. Set the id to `pirate-code`.
1. Create a new database.
   1. It should be in the `pirate-code` project.
   1. Set the id to `pirate-coins`.
1. Create a new collection.

   1. It should be in the `pirate-coins` database.
   1. Set the id to `coins`.
   1. Set the permissions to the `coins` collection to the following:

      | Type | Create | Read | Write | Delete |
      | ---- | ------ | ---- | ----- | ------ |
      | All  | ✅     | ✅   | ✅    | ❌     |

1. Verify that `.env.example` was renamed to `.env`, and that `direnv` works.
1. Run the "Dart: run build_runner" VS Code task.
1. Launch the app using the VS Code Run and Debug launcher.
   1. See if the app works.
   1. If not, file an issue with the documentation label.
