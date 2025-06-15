#!/usr/bin/env python3

import os
import sys
import subprocess

def create_project(folder_name, language_extension):
  """Creates a new project folder, navigates into it,
  creates a main file, and opens it in VS Code.
  """

  try:
    os.mkdir(folder_name)
    os.chdir(folder_name)
    open(f"main.{language_extension}", 'a').close()
    subprocess.run(["codium", "."])

  except FileExistsError:
    print(f"Error: Folder '{folder_name}' already exists.")
  except FileNotFoundError:
    print("Error: 'codium' command not found. Make sure VS Code is installed and added to your PATH.")
  except Exception as e:
    print(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
  if len(sys.argv) != 3:
    print("Usage: create_project <folder_name> <language_extension>")
    sys.exit(1)

  folder_name = sys.argv[1]
  language_extension = sys.argv[2]

  create_project(folder_name, language_extension)
