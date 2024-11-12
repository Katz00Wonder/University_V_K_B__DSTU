$cert = New-SelfSignedCertificate -Subject "Cert for laba” -CertStoreLocation "cert:\LocalMachine\My" -NotAfter (Get-Date).AddYears(3)


Get-ChildItem -Path "cert:\LocalMachine\My" | Where-Object { $_.Thumbprint -eq $cert.Thumbprint }