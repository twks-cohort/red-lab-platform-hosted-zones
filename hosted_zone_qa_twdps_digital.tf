# *.qa.twdps.digital

# define a provider in the account where this subdomain will be managed
provider "aws" {
  alias  = "subdomain_qa_cohorts_red"
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
    session_name = "red-lab-platform-hosted-zones"
  }
}

# create a route53 hosted zone for the subdomain in the account defined by the provider above
module "subdomain_qa_cohorts_red" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.0.0"
  create  = true

  providers = {
    aws = aws.subdomain_qa_cohorts_red
  }

  zones = {
    "qa.${local.domain_cdicohorts_red}" = {
      tags = {
        cluster = "nonprod"
      }
    }
  }

  tags = {
    pipeline = "red-lab-platform-hosted-zones"
  }
}

# Create a zone delegation in the top level domain for this subdomain
module "subdomain_zone_delegation_qa_cohorts_red" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.0.0"
  create  = true

  providers = {
    aws = aws.domain_cdicohorts_red
  }

  private_zone = false
  zone_name = local.domain_cdicohorts_red
  records = [
    {
      name            = "qa"
      type            = "NS"
      ttl             = 172800
      zone_id         = data.aws_route53_zone.zone_id_cdicohorts_red.id
      allow_overwrite = true
      records         = lookup(module.subdomain_qa_cohorts_red.route53_zone_name_servers,"qa.${local.domain_cdicohorts_red}")
    }
  ]

  depends_on = [module.subdomain_qa_cohorts_red]
}
