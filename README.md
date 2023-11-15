Amazon EKS (Elastic Kubernetes Service)
=======================================

Amazon EKS is a fully managed Kubernetes service. Customers trust EKS to run their most sensitive and mission critical applications because of its security, reliability, and scalability.

This module will create an EKS cluster on AWS. It will have a control plane and you can register multiple heterogeneous node groups as data plane.
This module will give you a utility bash script to set up a kubernetes configuration file to access the EKS cluster.
This module has several sub-modules to deploy kubernetes controllers and utilities using helm provider.

EKS Cluster using terraform
===========================
This code use the terraform eks module to provision a cluster. For state storage S3 as backend is used. DynamoDB is used here to add.

backend_configs — Add config for state backends.

backend.tf — Registers S3 as the backend. S3 bucket name and key prefix are specified here.

config.tf — Common configurations for providers and terraform to be added here

main.tf — This is where EKS module is used. It consists of all the code for infra to provision.

variables.tf — File to declare variables to be used in main.tf

dev.tfvars — Here variable values are provided for dev environment. Similarly values for other environment can be provided using similar file {env}.tfvars

The current variables used in dev.tfvars will provision EKS cluster with managed node groups for stateful services and Fargate profiles for stateless services. The configuration for same can be customized by updating the dev.tfvars file.
