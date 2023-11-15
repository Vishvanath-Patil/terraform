Amazon EKS (Elastic Kubernetes Service)
Amazon EKS is a fully managed Kubernetes service. Customers trust EKS to run their most sensitive and mission critical applications because of its security, reliability, and scalability.

This module will create an EKS cluster on AWS. It will have a control plane and you can register multiple heterogeneous node groups as data plane.
This module will give you a utility bash script to set up a kubernetes configuration file to access the EKS cluster.
This module has several sub-modules to deploy kubernetes controllers and utilities using helm provider.

EKS Cluster using terraform
===========================
This code use the terraform eks module to provision a cluster. For state storage S3 as backend is used. DynamoDB is used here to add.

