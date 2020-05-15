# Molecule GitHub Action

This GitHub Action runs Molecule to test Ansible role.

## Inputs

```yaml
  molecule_command:
    description: |
      Commands:
        check        Use the provisioner to perform a Dry-Run.
        cleanup      Use the provisioner to cleanup changes.
        converge     Use the provisioner to configure instances.
        create       Use the provisioner to start the instances.
        dependency   Manage the role's dependencies.
        destroy      Use the provisioner to destroy the instances.
        drivers      List drivers.
        idempotence  Use the provisioner to test the idempotence.
        init         Initialize a new role or scenario.
        lint         Lint the role.
        list         List status of instances.
        login        Log in to one instance.
        matrix       List matrix of steps used to test instances.
        prepare      Use the provisioner to prepare the instances.
        reset        Reset molecule temporary folders.
        side-effect  Use the provisioner to perform side-effects to the instances.
        syntax       Use the provisioner to syntax check the role.
        test         Test cicle.
        verify       Run automated tests against instances.
    required: true
    default: 'test'
  converge_tags:
    description: |
      Run molecule converge with Ansible tags.
      Same like: molecule converge -- --tags foo,bar
    required: false  
    default: 'all'
```

## Usage

To use the action simply create an `yaml` file in `.github/workflows/` directory.  
If you want to test your Ansible tags, use `converge` molecule command and ansible tags.

### Basic example

This runs `molecule test`:

```yaml
on: push

jobs:
  molecule:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          path: "${{ github.repository }}"
      - name: Molecule
        uses: monolithprojects/action-molecule@master
```

### Example for testing the Ansible Tags

This runs `molecule converge -- --tags foo,bar`:

```yaml
on: push

jobs:
  molecule:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          path: "${{ github.repository }}"
      - name: Molecule
        uses: monolithprojects/action-molecule@master
        with:
          molecule_command: converge
          converge_tags: foo,bar
```
