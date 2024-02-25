<h1>Website Estático - Terraform Platform</h1>
Código Terraform para provisionamento de uma solução de site estático, sendo um bucket S3 com Cloudfront.

<h3>Autor</h3>
<li>Weslley Matos de Carvalho</li>
<li>Linkedin: <a href="https://linkedin.com/in/matcarv">https://linkedin.com/in/matcarv</a></li>
<li>E-mail: <a href="mailto:contato@matcarv.com">contato@matcarv.com</a>

<h3>Versões</h3>
<li>Terraform versão 1.2.5</li>
<li>AWS Provider versão 4.12.0</li>

<h3>Comandos</h3>

`terraform init`<br />
`terraform plan`<br />
`terraform apply --auto-approve`

<h3>Orientações</h3>
<li>No arquivo <b>main.tf</b> e <b>variables.tf</b>, subistitua os valores <i>"YOUR-***"</i> pelos valores que correspondem ao seu ambiente cloud.</li>
<br />

<i>`Lembre-se de configurar o main.tf e apontar o bucket S3, onde são armazenados os estados do provisionamento Terraform.`</i>

