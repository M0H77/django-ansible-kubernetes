# django-ansible-kubernetes

## Description
This repository contains a sample Django application and the necessary configuration files to deploy it using Ansible, Docker, and Kubernetes. The deployment involves setting up a CentOS server, installing dependencies, configuring a PostgreSQL database, Dockerizing the application, and deploying it on a Kubernetes cluster.

## Prerequisites
Before you begin, ensure that you have the following prerequisites installed:
- Ansible
- Docker
- Kubernetes (kubectl and a Kubernetes cluster)

## Notes
- A `.env` file is included inside the djangoApp/djangoApp/ folder.
- The `django.yaml` ansible playbook is configured to use this repository
- The `django-deployment.yaml` kubernetes deployment file is configured to use this django container `m0h77/django-app:latest` available at https://hub.docker.com/r/m0h77/django-app.

## Deployment Steps

### Part 1: Deploying the Django Application with Ansible
1. Clone this repository.
2. Navigate to the `ansible` folder.
3. Update the `hosts` file with the target CentOS server's IP address or hostname and the necessary configuration variables, such as Django settings and database credentials.
4. Run `./ansible.sh system.yaml`  to create a new user and SSH key and add it to your Git repo as a deployment key.
5. Run `/ansible.sh packages.yaml` to update and install packages.
6. Run `./ansible.sh postgresql.yaml` to set up the PostgreSQL database.
7. Run `./ansible.sh django.yaml` to deploy the Django app.

### Part 2: Dockerizing and Deploying with Kubernetes
1. Ensure that you have a running Kubernetes cluster and the `kubectl` command-line tool configured to access the cluster.
2. Build the Docker image for the Django application: `docker build -t django-app .`
3. Push the Docker image to a container registry accessible by your Kubernetes cluster.
   Alternatively, you can use this ready container `m0h77/django-app:latest` available at https://hub.docker.com/r/m0h77/django-app.
4. Update the `kubernetes/<deployment>.yaml` files with the appropriate image and environment variables.
5. Apply the Kubernetes resources to deploy the application and database:
   - `kubectl apply -f django-deployment.yaml`
   - `kubectl apply -f django-service.yaml`
   - `kubectl apply -f postgres-deployment.yaml`
   - `kubectl apply -f postgres-service.yaml`

## Directory Structure
- `ansible/`: Contains Ansible playbook and configuration files for deploying the Django application and setting up the PostgreSQL database.
- `kubernetes/`: Includes Kubernetes deployment files for deploying the Dockerized application and database.
- `django-app/`: Contains the Django application code.
- `Dockerfile`: The Dockerfile for containerizing the Django application.
- `docker-compose.yml`: The docker-compose.yml file for running the application using Docker.
