require 'awspec'

describe route53_hosted_zone('cdicohorts.red.') do
  it { should exist }
end

describe route53_hosted_zone('dev.cdicohorts.red.') do
  it { should exist }
end

describe route53_hosted_zone('nonprod-us-east-2.cdicohorts.red.') do
  it { should exist }
end

describe route53_hosted_zone('prod.cdicohorts.red.') do
  it { should exist }
end

describe route53_hosted_zone('qa.cdicohorts.red.') do
  it { should exist }
end