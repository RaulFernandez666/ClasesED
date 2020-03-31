Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Noticias COVID-19'
$form.Size = New-Object System.Drawing.Size(300,260)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(20,120)
$OKButton.Size = New-Object System.Drawing.Size(100,23)
$OKButton.Text = 'Generar noticias'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$SearchButton = New-Object System.Windows.Forms.Button
$SearchButton.Location = New-Object System.Drawing.Point(20,150)
$SearchButton.Size = New-Object System.Drawing.Size(100,23)
$SearchButton.Text = 'Mostrar mapa'
$SearchButton.Add_Click({start chrome https://gisanddata.maps.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6})
$form.Controls.Add($SearchButton)

$GoogleFormButton = New-Object System.Windows.Forms.Button
$GoogleFormButton.Location = New-Object System.Drawing.Point(160,120)
$GoogleFormButton.Size = New-Object System.Drawing.Size(100,82)
$GoogleFormButton.Text = 'Formulario de estado'
$GoogleFormButton.Add_Click({start chrome https://docs.google.com/forms/d/e/1FAIpQLScOoj9Nb38wgQ4TG1Gs3I7mukWPWZeNbDp79sQIFqt72D1JLg/viewform?usp=sf_link})
$form.Controls.Add($GoogleFormButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(20,180)
$CancelButton.Size = New-Object System.Drawing.Size(100,23)
$CancelButton.Text = 'Salir'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Sobre que pais deseas obtener informacion:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.Listbox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)

$listBox.SelectionMode = 'MultiExtended'

[void] $listBox.Items.Add('España')
[void] $listBox.Items.Add('Italia')
[void] $listBox.Items.Add('Francia')
[void] $listBox.Items.Add('China')
[void] $listBox.Items.Add('Alemania')

$listBox.Height = 70
$form.Controls.Add($listBox)
$form.Topmost = $true

$result = $form.ShowDialog()

$x = $listBox.SelectedItems

switch ($x) {
    España 
        {
        $url='https://elpais.com/sociedad/2020-03-16/ultimas-noticias-del-coronavirus-y-el-estado-de-alarma-en-directo.html'
        $result = Invoke-WebRequest $url
        $encabezado = $result.AllElements | Where Class -eq 'font_secondary color_gray_ultra_dark ' | %{$_.innerText}
        $datos = $result.AllElements | Where Class -eq 'font_secondary color_gray_dark ' | %{$_.innerText}
        $encabezado,$datos | out-File "C:\Prueba\NoticiasEspaña.txt" 
        }
    Italia 
    {
        $url1='https://www.clarin.com/mundo/coronavirus-italia-nuevas-medidas-gobierno-pais-5-500-muertos-651-ultimas-24-hora_0__p9sYnBiL.html'
        $result1 = Invoke-WebRequest $url1
        $encabezado1 = $result1.AllElements | Where Class -eq 'title' | %{$_.innerText}
        $datos1 = $result1.AllElements | Where Class -eq 'description' | %{$_.innerText}
        $encabezado1,$datos1 | out-File "C:\Prueba\NoticiasItalia.txt"
    }
    Francia 
    {
        $url='https://www.infobae.com/america/mundo/2020/03/21/francia-confirmo-112-nuevas-muertes-por-coronavirus-en-un-dia-y-ya-son-562-victimas-fatales-en-total/'
        $result = Invoke-WebRequest $url
        $encabezado = $result.AllElements | Where Class -eq 'article-header hed-first col-sm-12' | %{$_.innerText}
        $encabezado , $datos | out-File "C:\Prueba\NoticiasFrancia.txt"
    }
    China 
    {
        $url='https://www.elimparcial.es/noticia/209129/mundo/ultima-hora-del-coronavirus-en-china:-quinto-dia-con-menos-de-diez-muertes.html'
        $result = Invoke-WebRequest $url
        $encabezado = $result.AllElements | Where Class -eq 'noticia 209129' | %{$_.innerText}
        $datos = $result.AllElements | Where Class -eq 'texto' | %{$_.innerText}
        $encabezado , $datos | out-File "C:\Prueba\NoticiasChina.txt" 
    }
    Alemania 
    {
        $url='https://elpais.com/sociedad/2020-03-22/alemania-prohibe-las-reuniones-de-mas-de-dos-personas.html'
        $result = Invoke-WebRequest $url
        $encabezado = $result.AllElements | Where Class -eq 'article-header basic | ' | %{$_.innerText}
        $encabezado = $result.AllElements | Where Class -eq '' | %{$_.innerText}
        $encabezado , $datos | out-File "C:\Prueba\NoticiasAlemania.txt"
    }
}
