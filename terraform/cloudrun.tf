resource "google_cloud_run_v2_service" "sponsor-app" {
  name                 = "sponsor-app"
  location             = "asia-northeast1"
  invoker_iam_disabled = true

  template {
    service_account = "sponsor-app@sekigahara01.iam.gserviceaccount.com"

    containers {
      name  = "sponsor-app-1"
      image = "asia-northeast1-docker.pkg.dev/sekigahara01/sponsor-app/sponsor-app:latest"

      command = ["bash"]
      args    = ["/docker_entrypoint.sh", "/usr/local/bin/bundle exec puma -C config/puma.rb"]

      resources {
        limits = {
          memory = "512Mi"
        }
        cpu_idle = true // request-based pricing
      }

      env {
        name  = "AWS_REGION"
        value = "ap-northeast-1"
      }
      env {
        name  = "AWS_ROLE_ARN"
        value = "arn:aws:iam::985623304185:role/Sek01SponsorAppProduction"
      }
      env {
        name  = "AWS_ACCESS_KEY_ID"
        value = "AKIA6K652C74SBHXYVB3"
      }
      env {
        name  = "AWS_SECRET_ACCESS_KEY"
        value_source {
          secret_key_ref {
            secret  = "sponsor-app-aws-secret-access-key"
            version = 1
          }
        }
      }
      env {
        name  = "DEFAULT_URL_HOST" // for email
        value = "sponsor-app-718943728422.asia-northeast1.run.app"
      }
      env {
        name  = "DEFAULT_EMAIL_ADDRESS"
        value = "team@toykorubykaigi12.org"
      }
      env {
        name  = "DEFAULT_EMAIL_HOST"
        value = "tokyorubykaigi12.org"
      }
      env {
        name  = "GITHUB_APP_ID"
        value = "2640000"
      }
      env {
        name  = "GITHUB_CLIENT_ID"
        value = "Iv23liu5Vi5HUlhmWJgL"
      }
      env {
        name  = "GITHUB_CLIENT_PRIVATE_KEY"
        value_source {
          secret_key_ref {
            secret  = "sponsor-app-github-client-private-key"
            version = 1
          }
        }
      }
      env {
        name  = "GITHUB_CLIENT_SECRET"
        value_source {
          secret_key_ref {
            secret  = "sponsor-app-github-client-secret"
            version = 1
          }
        }
      }
      env {
        name  = "GITHUB_REPO"
        value = "SekigaharaRubyKaigi/ops"
      }
      env {
        name  = "MAILGUN_SMTP_LOGIN"
        value = "sek01@tokyorubykaigi12.org"
      }
      env {
        name  = "MAILGUN_SMTP_PASSWORD"
        value_source {
          secret_key_ref {
            secret  = "sponsor-app-mailgun-smtp-password"
            version = 1
          }
        }
      }
      env {
        name  = "MAILGUN_SMTP_PORT"
        value = "587"
      }
      env {
        name  = "MAILGUN_SMTP_SERVER"
        value = "smtp.mailgun.org"
      }
      env {
        name  = "ORG_NAME"
        value = "Sekigahara RubyKaigi 01 Team"
      }
      env {
        name  = "RAILS_ENV"
        value = "production"
      }
      env {
        name  = "RAILS_LOG_TO_STDOUT"
        value = "1"
      }
      env {
        name  = "RAILS_SERVE_STATIC_FILES"
        value = "1"
      }
      env {
        name  = "TITO_API_TOKEN"
        value = "abcdef123456"
      }
      env {
        name  = "SECRET_KEY_BASE"
        value_source {
          secret_key_ref {
            secret  = "sponsor-app-secret-key-base"
            version = 1
          }
        }
      }
      env {
        name  = "SLACK_WEBHOOK_URL"
        value_source {
          secret_key_ref {
            secret  = "sponsor-app-slack-webhook-url"
            version = 1
          }
        }
      }
      env {
        name  = "S3_FILES_BUCKET"
        value = "sek01-sponsor-app"
      }
      env {
        name  = "S3_FILES_PREFIX"
        value = "production/"
      }
      env {
        name  = "S3_FILES_REGION"
        value = "ap-northeast-1"
      }
      env {
        name  = "S3_FILES_ROLE"
        value = "arn:aws:iam::985623304185:role/Sek01SponsorAppImageUploader"
      }
    }
    scaling {
      min_instance_count = 0
      max_instance_count = 1
    }
  }
}
