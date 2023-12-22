**GitHub Actions Reusable Workflow for Version Tagging**

This repository contains a reusable GitHub Actions workflow that helps automate version tagging for your projects. It leverages a Docker container from Docker Hub to perform the tagging process. Below are the instructions on how to set up and use this workflow effectively.

### Workflow Setup

To implement this workflow in your repository, follow these steps:

1. Create or edit the `.github/workflows/version-tagging.yml` file in your repository.

2. Copy and paste the following YAML content into the `version-tagging.yml` file:

```yaml
name: Version Tagging

on:
  workflow_dispatch:
    inputs:
      version:
        description: "Version to tag"
        required: true

jobs:
  tag:
    uses: singnet/das-scripts-pipeline/.github/workflows/action.yml@master
    with:
      version: ${{ github.event.inputs.version }}
      version-strategy: bump-version-from-variable-value
      job-image-namespace: trueagi
      job-image-version-semver: semantic-versioning
      main-branch: main
      version-tag-regex-pattern: /^v\d+\.\d+\.\d+$/
      version-require-confirmation: "true"
```

3. In the above code, the workflow is triggered using the `workflow_dispatch` event, which allows you to manually trigger the workflow from the GitHub Actions UI. You will be prompted to provide a value for the `version` input when triggering the workflow.

4. Customize the other variables in the same way as described in the previous response to fit your project's requirements.

### Docker Image

This workflow leverages a Docker container to perform the version tagging process. The details of this image are specified by the following variables:

- `job-image-namespace`: The namespace on Docker Hub where the image is hosted.
- `job-image-version-semver`: The version of the Docker image to use.

That's it! With this workflow in place, you can trigger the workflow manually from the GitHub Actions UI by providing the desired version value.

### Integration Github Mattermost

This workflow utilizes the action available in the repository [singnet/integration-github-mattermost](https://github.com/singnet/integration-github-mattermost) to notify a Mattermost channel about the availability of a new version.

#### Environment Variables

| Variable               | Purpose                                                                                                                                              | Optional |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| MATTERMOST_WEBHOOK_URL | The Mattermost Incoming Webhook URL.                                                                                                                 | No       |
| MATTERMOST_CHANNEL     | The name of the channel where you want to post messages. If not specified, the message will be posted in the channel set up in the webhook creation. | Yes      |
| MATTERMOST_USERNAME    | The name of the sender of the message, for example, "GitHubAction".                                                                                  | Yes      |
| MATTERMOST_ICON        | The user or bot icon shown with the Mattermost message.                                                                                              | Yes      |

## Action Example

```yaml
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Notify Mattermost
        uses: singnet/integration-github-mattermost@master
        env:
          MATTERMOST_WEBHOOK_URL: ${{ secrets.MATTERMOST_WEBHOOK_URL }}
          MATTERMOST_CHANNEL: ${{ secrets.MATTERMOST_CHANNEL }}
          MATTERMOST_USERNAME: "GitHubAction"
          MATTERMOST_ICON: "https://example.com/icon.png"
```
