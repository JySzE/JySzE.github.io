# JySzE.github.io

Host and run scripts from this repository:

```powershell
irm https://jysze.github.io/scripts | iex
```

The launcher reads [`manifest.json`](./manifest.json), presents the available
scripts, and asks for confirmation before downloading and running a selection.
It supports `.ps1`, `.bat`/`.cmd`, and `.py` files. Python scripts require a
Python installation; batch files require Windows. Only run scripts you trust;
review their source in [`library/`](./library/) before confirming.

## Adding a script

1. Add a `.ps1`, `.bat`, `.cmd`, or `.py` file under [`library/`](./library/).
2. Add its name, description, and relative path to the `scripts` array in
   [`manifest.json`](./manifest.json).
3. Publish the changes to GitHub Pages.

GitHub Pages does not provide a directory listing, so each file must be added
to the manifest to appear in the launcher.

The manifest uses this format:

```json
{
  "version": 1,
  "scripts": [
    {
      "name": "Example helper",
      "description": "What the helper does",
      "path": "library/example-helper.ps1"
    }
  ]
}
```
