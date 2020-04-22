/*
provider "aws" {
  profile = "default"
  region  = "us-east-2"
}
*/

resource "aws_iam_user" "users" {
  name          = "profbob"
  force_destroy = "true"
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.users.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user_login_profile" "profile" {
  user                    = aws_iam_user.users.name
  pgp_key                 = filebase64("./profbob.gpg.pubkey")
  password_reset_required = "true"
}

/*by Default as a best secured way, terraform will not allow to set password from code. 
A random generated password and enable password_reset_required, so user will change password when user login for first time.
as a result of output command, an encrypted password will be displayed on screen and can be decrypted by below command. This need GPG public key.
echo "encrypted password displayed on screen"|base64 -d|gpg -dq
Login to console using this password and change password to "MyCoolProject3"
*/
