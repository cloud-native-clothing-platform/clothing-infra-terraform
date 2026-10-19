locals { name = "${var.project_name}-${var.environment}" }
resource "aws_s3_bucket" "frontend" {
  bucket_prefix = "${local.name}-web-"
  force_destroy = false
  tags = { Project = var.project_name, Environment = var.environment, ManagedBy = "Terraform" }
}
resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}
resource "aws_ecr_repository" "services" {
  for_each = toset(["product","user","order","payment","inventory","shipping"])
  name = "${local.name}/${each.key}-service"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration { scan_on_push = true }
  encryption_configuration { encryption_type = "AES256" }
  tags = { Project = var.project_name, Environment = var.environment }
}
