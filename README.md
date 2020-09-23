# Project Details

## Title

Provision Azure Web App for Docker Compose to run multi-container MySQL and Wordpress within the app service, which store persistent data for the containers in an Azure Storage Account.

## Description

Run a cost effective Wordpress website using only SaaS/PaaS services. With a combination of Azure Web App, Docker Compose (in preview), a Storage Account and Storage Mounts (in preview) from the App Service. Intention of this project was to test out Docker Compose and Storage Mounts within an App Service.

#### Resources Provisioned

* App Service Plan
* App Service (Linux)
* Docker Compose Containers (in preview)
  * MySQL
  * Wordpress
* Storage Account
* Storage Mount for App Service (in preview)

### Prerequisites

* [Download and Install Terraform](https://www.terraform.io/downloads.html)
* [Create a Service Principal for Terraform](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html#creating-a-service-principal)

### Installing

* Populate client_id and client_secret inside global_main.tf from the Service Principal you created in the prerequisites
* Populate subscription_id and tenant_id inside global_main.tf from your Azure tenant information

The [terraform init](https://www.terraform.io/docs/commands/init.html) command is used to initialize a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control. It is safe to run this command multiple times

```
terraform init
```

The [terraform plan](https://www.terraform.io/docs/commands/plan.html) command is used to create an execution plan. Terraform performs a refresh, unless explicitly disabled, and then determines what actions are necessary to achieve the desired state specified in the configuration files. This command is a convenient way to check whether the execution plan for a set of changes matches your expectations without making any changes to real resources or to the state. For example, terraform plan might be run before committing a change to version control, to create confidence that it will behave as expected.

```
terraform plan
```

The [terraform apply](https://www.terraform.io/docs/commands/apply.html) command is used to apply the changes required to reach the desired state of the configuration, or the pre-determined set of actions generated by a terraform plan execution plan.

```
terraform apply
```

On first startup of the service you might see "2020-06-14T08:56:01.898Z INFO  - Stopping site 'your-app-service-name' because it failed during startup." under Container Settings > Logs. The Log Stream will also have a single line of "Welcome, you are now connected to log-streaming service". Restart the app service to bring it into life. The Log Stream should then trail the Docker images being pulled.

Check within the storage account which was provisioned that you see folders and files being created in the 'database' and 'wordpress' shares, confirming that the storage mount is being used by the containers.

On second startup of the service after pulling the images and attempting to start the containers you might again see "2020-06-14T08:56:01.898Z INFO  - Stopping site 'your-app-service-name' because it failed during startup." under the Log Stream. Stop then start the app service to bring it into life. The log stream should end with "Container cbchalmers_wordpress_0_52f57905 for site cbchalmers initialized successfully and is ready to serve requests" You should now be able to view the Wordpress installation page at https://your-app-service-name.azurewebsites.net.

### Troubleshooting
* Review Container Settings > Logs.
* Review Log Stream

### Removing

The [terraform destroy](https://www.terraform.io/docs/commands/destroy.html) command is used to destroy the Terraform-managed infrastructure.

```
terraform destroy
```

## Built With

* [Terraform Azure RM Provider](https://www.terraform.io/docs/providers/azurerm/index.html)

## References

* [Terraform Commands](https://www.terraform.io/docs/commands/index.html)
* [Terraform Azure RM Provider](https://www.terraform.io/docs/providers/azurerm/index.html)
* [Tutorial: Create a multi-container (preview) app in Web App for Containers](https://docs.microsoft.com/en-gb/azure/app-service/containers/tutorial-multi-container-app)
* [Serve content from Azure Storage in App Service on Linux](https://docs.microsoft.com/en-gb/azure/app-service/containers/how-to-serve-content-from-azure-storage)

## Authors

Chris Chalmers - [LinkedIn](https://uk.linkedin.com/in/chris-chalmers), [Azure DevOps](https://dev.azure.com/cbchalmers/Personal%20Development), [GitHub](https://github.com/cbchalmers)

# Auto Generated by [terraform-docs](https://github.com/terraform-docs/terraform-docs)

## Requirements

| Name | Version |
|------|---------|
| azurerm | 2.12.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | 2.12.0 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app_service_name | Desired external URL. This has to be globally unique to become https://your-app-service-name.azurewebsites.net | `string` | n/a | yes |
| mysql_password | Appropriate values which will be used to log into the database service | `string` | n/a | yes |
| mysql_root_password | Appropriate values which will be used to log into the database service | `string` | n/a | yes |
| resource_location | Desired location to provision the resources. Eg UK South | `string` | n/a | yes |
| resource_prefix | Desired prefix for the provisioned resources. Eg CC-D-UKS | `string` | n/a | yes |

## Outputs

No output.

