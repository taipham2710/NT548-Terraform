package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Initialize Terraform
func setup(t *testing.T) *terraform.Options {
	terraformOptions := &terraform.Options{
		TerraformDir: "../",
	}

	return terraformOptions
}

// Module Tests
func TestInfra(t *testing.T) {
	terraformOptions := setup(t)
	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	t.Run("VPC is created with CIDR block", func(t *testing.T) {
		vpcID := terraform.Output(t, terraformOptions, "vpc_id")
		vpcCIDR := terraform.Output(t, terraformOptions, "vpc_cidr_block")

		assert.NotEmpty(t, vpcID, "VPC ID should not be empty")
		assert.NotEmpty(t, vpcCIDR, "VPC CIDR block should not be empty")
		assert.Regexp(t, `^\d+\.\d+\.\d+\.\d+/\d+$`, vpcCIDR, "CIDR block should be in correct format")
	})

	t.Run("Public subnet is created correctly", func(t *testing.T) {
		publicSubnetID := terraform.Output(t, terraformOptions, "public_subnet_id")
		publicSubnetCIDR := terraform.Output(t, terraformOptions, "public_subnet_cidr_block")

		assert.NotEmpty(t, publicSubnetID, "Public subnet ID should not be empty")
		assert.NotEmpty(t, publicSubnetCIDR, "Public subnet CIDR should not be empty")
		assert.Regexp(t, `^\d+\.\d+\.\d+\.\d+/\d+$`, publicSubnetCIDR, "CIDR block should be in correct format")
	})

	t.Run("Private subnet is created correctly", func(t *testing.T) {
		privateSubnetID := terraform.Output(t, terraformOptions, "private_subnet_id")
		privateSubnetCIDR := terraform.Output(t, terraformOptions, "private_subnet_cidr_block")

		assert.NotEmpty(t, privateSubnetID, "Private subnet ID should not be empty")
		assert.NotEmpty(t, privateSubnetCIDR, "Private subnet CIDR should not be empty")
		assert.Regexp(t, `^\d+\.\d+\.\d+\.\d+/\d+$`, privateSubnetCIDR, "CIDR block should be in correct format")
	})

	t.Run("Internet Gateway is created and attached to VPC", func(t *testing.T) {
		igwID := terraform.Output(t, terraformOptions, "internet_gateway_id")

		assert.NotEmpty(t, igwID, "Internet Gateway ID should not be empty")
		assert.Contains(t, igwID, "igw-", "Internet Gateway ID should have correct prefix")
	})

	t.Run("NAT Gateway is created in public subnet", func(t *testing.T) {
		natGatewayID := terraform.Output(t, terraformOptions, "nat_gateway_id")

		assert.NotEmpty(t, natGatewayID, "NAT Gateway ID should not be empty")
		assert.Contains(t, natGatewayID, "nat-", "NAT Gateway ID should have correct prefix")
	})

	t.Run("Public route table is created with IGW route", func(t *testing.T) {
		publicRouteTableID := terraform.Output(t, terraformOptions, "public_route_table_id")

		assert.NotEmpty(t, publicRouteTableID, "Public route table ID should not be empty")
		assert.Contains(t, publicRouteTableID, "rtb-", "Route table ID should have correct prefix")
	})

	t.Run("Private route table is created with NAT Gateway route", func(t *testing.T) {
		privateRouteTableID := terraform.Output(t, terraformOptions, "private_route_table_id")

		assert.NotEmpty(t, privateRouteTableID, "Private route table ID should not be empty")
		assert.Contains(t, privateRouteTableID, "rtb-", "Route table ID should have correct prefix")
	})

	t.Run("Public security group is created with proper rules", func(t *testing.T) {
		publicSGID := terraform.Output(t, terraformOptions, "public_security_group_id")

		assert.NotEmpty(t, publicSGID, "Public security group ID should not be empty")
		assert.Contains(t, publicSGID, "sg-", "Security group ID should have correct prefix")
	})

	t.Run("Private security group is created with proper rules", func(t *testing.T) {
		privateSGID := terraform.Output(t, terraformOptions, "private_security_group_id")

		assert.NotEmpty(t, privateSGID, "Private security group ID should not be empty")
		assert.Contains(t, privateSGID, "sg-", "Security group ID should have correct prefix")
	})

	t.Run("Public EC2 instance is launched in public subnet", func(t *testing.T) {
		publicInstanceID := terraform.Output(t, terraformOptions, "public_instance_id")
		publicInstanceIP := terraform.Output(t, terraformOptions, "public_instance_ip")

		assert.NotEmpty(t, publicInstanceID, "Public instance ID should not be empty")
		assert.Contains(t, publicInstanceID, "i-", "Instance ID should have correct prefix")
		assert.NotEmpty(t, publicInstanceIP, "Public instance IP should not be empty")
		assert.Regexp(t, `^\d+\.\d+\.\d+\.\d+$`, publicInstanceIP, "IP address should be in correct format")
	})

	t.Run("Private EC2 instance is launched in private subnet", func(t *testing.T) {
		privateInstanceID := terraform.Output(t, terraformOptions, "private_instance_id")
		privateInstanceIP := terraform.Output(t, terraformOptions, "private_instance_ip")

		assert.NotEmpty(t, privateInstanceID, "Private instance ID should not be empty")
		assert.Contains(t, privateInstanceID, "i-", "Instance ID should have correct prefix")
		assert.NotEmpty(t, privateInstanceIP, "Private instance IP should not be empty")
		assert.Regexp(t, `^\d+\.\d+\.\d+\.\d+$`, privateInstanceIP, "IP address should be in correct format")
	})
}
