# Ideally there will be an acm cert here along with an alias record back to alb


# resource "aws_route53_zone" "main" {
#   name = "trufan.io"
# }

# resource "aws_route53_zone" "dev" {
#   name = "2048.trufan.io"
#   tags = {
#     Environment = "dev"
#   }
# }

# resource "aws_route53_record" "dev-ns" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = "2048.trufan.io"
#   type    = "NS"
#   ttl     = "30"
#   records = aws_route53_zone.dev.name_servers
# }

# resource "aws_route53_record" "dev-alias" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "2048.trufan.io"
#   type    = "A"
#   ttl     = "30"
#   records = [aws_elb.main.dns_name]
# }