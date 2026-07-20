# ============================================
# ecr.tf
# ============================================

resource "aws_ecr_repository" "payment_orchestration" {
  name                 = "payment-orchestration"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "payment-orchestration"
    Environment = "${var.environment}"
  }
}

resource "aws_ecr_lifecycle_policy" "payment_orchestration" {
  repository = aws_ecr_repository.payment_orchestration.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 10 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.payment_orchestration.repository_url
}
