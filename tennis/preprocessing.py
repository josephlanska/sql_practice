"""Sanitize CSV files so they can be imported into a SQL database."""


import os
from pathlib import Path


def clean_missing_values(src_dir, mod_dir, filename, placeholder="NA"):
    """
    Sanitize CSV files for import by replacing strings denoting missing values
    (e.g. 'NA') with empty strings.

    Parameters
    ----------
    src_dir : str or Path-like object
        Directory where the original CSV files are stored.
    mod_dir : str or Path-like object
        Directory where the modified files are to be saved.
    filename : str
        Filename of the CSV file to be modified.
    placeholder : str
        String denoting a missing value in the dataset.

    Returns
    -------
    None
    """

    # create the directory for the modified files if the directory doesn't exist
    if not os.path.isdir(mod_dir):
        os.mkdir(mod_dir)

    lines = []
    with open(src_dir / filename, "r") as infile:
        for line in infile:
            updated_line = line.replace(placeholder, "")
            lines.append(updated_line)

    with open(mod_dir / filename, "w") as outfile:
        outfile.write("".join(lines))


if __name__ == "__main__":

    # modify this line as needed
    BASE_DIR = Path("~").expanduser() / "Data"

    TENNIS_DATA_DIRNAME = "Tennis-Major-Tournaments-Match-Statistics"
    MOD_DATA_DIRNAME = TENNIS_DATA_DIRNAME + "_modified"

    DATA_DIR = BASE_DIR / TENNIS_DATA_DIRNAME
    MOD_DIR = BASE_DIR / MOD_DATA_DIRNAME

    for file in os.listdir(path=DATA_DIR):
        clean_missing_values(src_dir=DATA_DIR, mod_dir=MOD_DIR, filename=file)
