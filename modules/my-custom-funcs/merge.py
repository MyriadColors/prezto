import os
import sys

def merge(output_file=None, overwrite=False, *files):
    if not output_file:
        print("Error: No output file specified. Use -o or --output to specify the output file.")
        return 1

    # Clear or create the output file if overwrite is enabled
    if os.path.exists(output_file):
        if overwrite:
            try:
                with open(output_file, 'w'):
                    pass  # Truncate the file
            except IOError:
                print(f"Error: Could not clear '{output_file}'.")
                return 1
    else:
        try:
            with open(output_file, 'w'):
                pass  # Create the file
        except IOError:
            print(f"Error: Could not create '{output_file}'.")
            return 1

    for file in files:
        if os.path.isfile(file):
            try:
                with open(output_file, 'a') as out_file:
                    out_file.write(f"=== {file} ===\n")
                    with open(file, 'r') as in_file:
                        out_file.write(in_file.read())
                    out_file.write("\n")
            except IOError as e:
                print(f"Error writing to '{output_file}': {e}")
                return 1
        else:
            print(f"Warning: File '{file}' not found, skipping...")

    print(f"Files merged into '{output_file}'")
    return 0

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Merge files into a single output file.")
    parser.add_argument("-o", "--output", required=True, help="Specify the output file")
    parser.add_argument("-f", "--force", action="store_true", help="Overwrite the output file if it exists")
    parser.add_argument("files", nargs="*", help="List of files to merge")

    args = parser.parse_args()
    sys.exit(merge(args.output, args.force, *args.files))
