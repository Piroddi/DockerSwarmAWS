
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.ssm_instance_profile.name
}

resource "aws_iam_role" "ssm_instance_profile" {
  name = "Docker_swarm_ssm"
  path = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_full_access" {
  role       = aws_iam_role.ssm_instance_profile.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "secret_manager" {
  role       = aws_iam_role.ssm_instance_profile.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

resource "aws_iam_role_policy_attachment" "ecr" {
  role       = aws_iam_role.ssm_instance_profile.name
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
}

resource "aws_iam_role_policy_attachment" "s3" {
  role       = aws_iam_role.ssm_instance_profile.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}