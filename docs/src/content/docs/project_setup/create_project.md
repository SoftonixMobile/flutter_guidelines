---
title: Create a project
---

We have prepared a template project that serves as the foundation for all new projects. Every new project should be created using this [template](https://brickhub.dev/bricks/stx_project_template/) to ensure consistency and streamline the setup process.

To apply the template to a new project, we use the [mason](https://pub.dev/packages/mason) generator tool. The following script enables you to create a new project directly from the terminal with minimal effort:

```bash
#!/usr/bin/env bash

PROJECT_NAME=$1
PLATFORMS="ios,android" # Default platforms

# Check if a custom --platforms argument is provided
if [[ $2 == --platforms=* ]]; then
  PLATFORMS="${2#--platforms=}"
fi

# Create Flutter project with specified platforms
flutter create "$PROJECT_NAME" --platforms="$PLATFORMS"
cd "$PROJECT_NAME" || exit

# Initialize Mason and apply the stx_project_template brick
mason init
mason add stx_project_template
mason make stx_project_template --project_name "$PROJECT_NAME" --on-conflict overwrite

# Fetch dependencies
flutter pub get
```

### How to create an alias?

Creating an alias allows you to quickly run the project creation script from anywhere in your terminal. Follow these steps:

1. **Save the script to a file**  
   Copy the script provided above and save it to a file, for example:  
   `~/scripts/stx_flutter_create.sh`

2. **Make the script executable**  
   Run the following command to give the script execution permissions:  
   ```bash
   chmod +x ~/scripts/stx_flutter_create.sh
   ```

3. **Add an alias to your shell configuration**  
   Open your shell configuration file (e.g., `~/.zshrc` or `~/.bashrc`) in a text editor:  
   ```bash
   nano ~/.zshrc
   ```
   Add the following line to create an alias:  
   ```
   alias stx_flutter_create=$HOME/scripts/stx_flutter_create.sh
   ```
   Save and exit the editor (press `Control + X`, then `Y`, and hit `Enter`).

4. **Apply the changes**  
   Reload your shell configuration to apply the alias:  
   ```bash
   source ~/.zshrc
   ```

### Using the alias

Once the alias is set up, you can create a new project by running:  
```bash
stx_flutter_create project_name --platforms=ios,android
```

:::note
> To use the [Mason CLI](https://pub.dev/packages/mason_cli), ensure it is installed on your machine.
:::