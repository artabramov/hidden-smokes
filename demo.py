"""
This script generates demo data by executing Behave feature files for
collections, datafiles, and comments based on specified command-line
arguments. It uses the --collections, --datafiles, and --comments
options to determine the number of each type of demo data to create. 
"""

import argparse
import os

def main():
    parser = argparse.ArgumentParser(
        description="Generates demo data by running specific Behave "
                    "feature files. You can create demo collections, "
                    "datafiles, and comments as needed.")

    parser.add_argument(
        "--collections", type=int, required=False,
        help="Specify the number of demo collections to create. If "
             "omitted, no collections will be created.")
    
    parser.add_argument(
        "--datafiles", type=int, required=False,
        help="Specify the number of demo datafiles to create. If "
             "omitted, no datafiles will be created.")

    parser.add_argument(
        "--comments", type=int, required=False,
        help="Specify the number of demo comments to create. If "
             "omitted, no comments will be created.")

    args = parser.parse_args()

    if args.collections:
        for i in range(args.collections):
            os.system("behave /smokes/app/features/demo_collection.feature --format null")

    if args.datafiles:
        for i in range(args.datafiles):
            os.system("behave /smokes/app/features/demo_datafile.feature --format null")

    if args.comments:
        for i in range(args.comments):
            os.system("behave /smokes/app/features/demo_comment.feature --format null")


if __name__ == "__main__":
    main()
