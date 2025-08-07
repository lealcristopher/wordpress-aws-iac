---

# Highly Available & Secure WordPress E-commerce on AWS with Terraform & Ansible

## Overview

This project demonstrates a robust, scalable, and highly secure deployment of a WordPress e-commerce platform on Amazon Web Services (AWS). Leveraging Infrastructure as Code (IaC) with **Terraform** and configuration management with **Ansible**, this setup focuses on automation, resilience, and adherence to security best practices for critical web applications.

Designed as a personal learning journey and a portfolio showcase, this repository incrementally builds a production-ready WordPress environment, ideal for freelance work or as a foundation for similar cloud-native deployments.

## Key Technologies Utilized

*   **AWS:** The foundational cloud provider for all infrastructure resources.
    *   **Amazon EC2:** For scalable compute capacity, provisioned within Auto Scaling Groups.
    *   **Amazon RDS (MySQL):** A fully managed relational database service for WordPress data, ensuring high availability and automated backups.
    *   **Amazon S3:** Used for static content storage, media offloading, and potentially Terraform state backend.
    *   **Application Load Balancer (ALB):** Distributes incoming traffic across multiple EC2 instances for high availability and fault tolerance.
    *   **AWS WAF (Web Application Firewall):** Provides protection against common web exploits and bots that may affect application availability, compromise security, or consume excessive resources.
    *   **Amazon Route 53:** Manages DNS for domain resolution and routing traffic.
*   **Terraform:** For provisioning and managing the entire AWS infrastructure declaratively. This ensures idempotent and repeatable deployments.
*   **Ansible:** For automating the configuration of WordPress, web servers (Nginx/Apache), PHP, and other dependencies on EC2 instances. It ensures consistency and enables rapid application deployment.
*   **WordPress:** The e-commerce platform itself (e.g., with WooCommerce).

## Architecture & Key Features

### The project is structured to achieve:

| *   **High Availability:** Multiple EC2 instances behind an ALB, distributed across different Availability Zones, backed by an RDS Multi-AZ deployment. |
|---|


*   **Scalability:** Auto Scaling Groups for EC2 instances allow the environment to automatically scale up or down based on demand.
*   **Security First:** Implementation of AWS WAF, secure networking (VPC, Security Groups), and Ansible playbooks for hardening the WordPress installation and underlying servers.
*   **Infrastructure as Code (IaC):** All infrastructure is defined in Terraform, allowing for versioning, peer review, and rapid disaster recovery.
*   **Configuration Automation:** Ansible ensures consistent and automated setup of the WordPress application, dependencies, and security configurations.
*   **Modular & Reusable Code:** The codebase is designed in a phased approach (see below) to be modular, making it easy to adapt for different projects and educational purposes.

## Phased Development Approach

### This project follows a phased methodology, allowing for incremental learning and version control of complex deployments:

| 1.  **Credentials & Provider Setup:** Initial Terraform configuration to connect with AWS. |
|---|


2.  **Basic EC2 Instance:** Provisioning a single EC2 instance for initial SSH connectivity and testing.
3.  **Ansible Integration:** Configuring the EC2 instance using basic Ansible commands.
4.  **Domain & DNS Configuration:** Setting up Route 53 for domain management.
5.  **RDS & S3 Integration:** Provisioning managed database and object storage.
6.  **WordPress Configuration (Ansible):** Full automation of WordPress installation and setup.
7.  **Load Balancer & Auto Scaling Group:** Implementing an ALB with multiple EC2 instances.
8.  **WAF Implementation:** Enhancing security with a Web Application Firewall.

## About the Author

Hi, I'm Cris, a Computer Engineer, Certified Ethical Hacker, and entrepreneur with a strong focus on cybersecurity. I'm leveraging AI for advanced technical support and strategic analysis. This project reflects my commitment to building secure, highly available systems and my interest in applying IaC and automation to real-world challenges, especially within the e-commerce security domain.

---