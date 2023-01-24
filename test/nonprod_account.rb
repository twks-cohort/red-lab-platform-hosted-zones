require 'awspec'

describe route53_hosted_zone('cdicohorts.red') do
  it { should exist }
end

describe route53_hosted_zone('dev-us-east-1.twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('dev-us-east-1.cdicohorts.red.') do
  it { should exist }
end
