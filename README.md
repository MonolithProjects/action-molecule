# Molecule GitHub Action

GitHub Action for Molecule (docker driver) to test your Ansible Roles including the Ansible-playbook arguments.  
This GitHub Action is small, multi stage built, Alpine Linux 3.12 based Docker image.  

## Inputs

```yaml
  molecule_command:
    description: |
      Molecule commands:
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
  converge_extra_args:
    description: |
      Run molecule converge with ansible-playbook arguments ( Same like: molecule converge -- --tags foo,bar --extra_vars "my_var=true").
    required: false
  scenario:
    description: |
      Run specific Molecule Scenario
    required: false
```

## Usage

To use the action simply create a `yaml` file in `.github/workflows/` directory. See the examples below. 

### Basic example

In this case the GitHub Action will run `molecule test`:

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
        uses: monolithprojects/action-molecule@v1.3.0
```

### Ansible-playbook arguments

In this case the GitHub Action will run `molecule converge -s special_scenario -- --tags foo,bar --extra_vars "my_var=true"`:

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
        uses: monolithprojects/action-molecule@v1.3.0
        with:
          molecule_command: converge
          scenario: special_scenario
          converge_extra_args: --tags foo,bar --extra_vars "my_var=true"
```
