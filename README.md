# LaTeX Reference Manager

This tool streamlines the creation and management of documentation in LaTeX. It simplifies the handling of cross-references between generated documents.

## Installation

This tool requires **PDFLaTeX** to generate PDF files and custom LaTeX macros for managing references. To install the required tools on Debian-based systems, run:

```bash
sudo apt-get install texlive-full
```

Ensure your system includes `make`, as it is used to manage the build process.

## Using LaTeX Reference Manager

### Add LaTeX Reference Manager to Your Project

Add the repository as a submodule to your project:

```bash
git submodule add git@github.com:bringauto/latex-references-manager.git
```

Initialize the LaTeX Reference Manager by calling the `init_manager` target in the `latex-references-manager/Makefile`. Preferably, run:

```bash
make -C latex-references-manager init_manager
```

If the LaTeX Reference Manager is not included as a submodule in the root of your project, you will need to configure two variables, `INIT_DIR` and `LIB_PATH`, during the initialization process. These variables specify the relative paths required to properly set up the manager.

#### Example Configuration

For instance, if the LaTeX Reference Manager resides in a subdirectory of your project (e.g., `another_dir/latex-references-manager`), you can initialize it using the following command:

```bash
make -C another_dir/latex-references-manager init_manager INIT_DIR=../../ LIB_PATH=another_dir/latex-references-manager/
```

This command creates symbolic links (symlinks) to the files in the LaTeX Reference Manager, making them accessible from the root of your project. This setup ensures that all cross-references, bibliography files, and other resources function seamlessly, regardless of where the manager is located within your project structure.

### Create a Project and Use It with LaTeX Reference Manager

When creating a new project, reuse the Makefile located in the example directory.

```sh
PROJECT_NAME := example
REPO_ROOT_DIR := ../

include $(REPO_ROOT_DIR)/Makefile.common

$(eval $(call COMMON_LOGIC, $(PROJECT_NAME), $(REPO_ROOT_DIR)))
```

 In this Makefile, set `PROJECT_NAME` to the name of your project (the name of the main `.tex` file without the `.tex` extension) and `REPO_ROOT_DIR` to the relative path to the root directory of your project. This Makefile includes logic from `Makefile.common` in your root directory, enabling you to build your project with the LaTeX Reference Manager. It also includes `clean` and `cleanall` targets.

If you want to add more targets to your Makefile, you can, but for building, you should use the targets provided in `Makefile.common`. Otherwise, the LaTeX Reference Manager might not work properly.

To build your project, use the `make` command in the project directory. If you want to build multiple documents at once, it is recommended to create a Makefile in the root of the entire project and call `make -C path_to_project` for each project from this Makefile.

```bash
make # Build the project
make clean # Clean the project temporary files
make cleanall # Clean the project temporary files and output PDF
```

### Use References Between Projects

#### Create a Record in the `references.tex` File

To use the LaTeX Reference Manager in your project for managing references, add a record for each document you want to reference in the `references.tex` file located in the root of your project. The record should follow this format:

```latex
\createref{name_of_reference}{path_to_output_pdf}
```

where:

- `name_of_reference` is the name you will use to reference this document in your project.
- `path_to_output_pdf` is the path to the output PDF file of this document relative to the root of your project, in the format `path/to/output` (without the `.pdf` extension).

#### Use References in Your Project

To use references in your project, include the following line in your main `.tex` file:

```latex
\input{references_lib/references_lib.tex}
```

This includes the LaTeX macros necessary for using references in your project. It works only when you use the provided `Makefile.common` to build your project, as it modifies the `TEXINPUTS` variable to include files from the root of your project.

To create a specific reference, use the `\getref{name_of_reference}` macro in your project. For example, to create a link to a document with the reference `document1`, use:

```latex
\href{\getref{document1}}{Link to document1.pdf}
```

#### LaTeX Reference Manager Configuration

To configure the LaTeX Reference Manager, use the `references_config.tex` file in the root of your project. You can set the following:

- **Output Mode:**  
  Switch between `pdf` and `html` modes by updating:

  ```latex
  \pdfhtmlmode{pdf} % or \pdfhtmlmode{html}
  ```

- **HTML Prefix:**  
  When generating HTML output, define the base URL prefix:

  ```latex
  \def\htmlprefix{https://bringauto.com/en/}
  ```

**Note:** HTML output is currently not supported. Implementing this feature will require `latexml` or similar tools.
