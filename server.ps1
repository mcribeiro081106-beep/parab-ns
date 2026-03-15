$Port = 3000

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()

Write-Host "Servidor rodando em http://localhost:$Port"
Write-Host "Pressione CTRL+C para parar"

while ($listener.IsListening) {
    try {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $filePath = $request.RawUrl -replace "^/", ""
        if ([string]::IsNullOrEmpty($filePath) -or $filePath -eq "") {
            $filePath = "index.html"
        }
        
        $fullPath = Join-Path (Get-Location) $filePath
        
        if (Test-Path $fullPath -PathType Leaf) {
            $fileContent = [System.IO.File]::ReadAllBytes($fullPath)
            $response.ContentLength64 = $fileContent.Length
            
            if ($fullPath -like "*.html") { 
                $response.ContentType = "text/html" 
            }
            elseif ($fullPath -like "*.css") { 
                $response.ContentType = "text/css" 
            }
            elseif ($fullPath -like "*.js") { 
                $response.ContentType = "application/javascript" 
            }
            elseif ($fullPath -like "*.png") { 
                $response.ContentType = "image/png" 
            }
            
            $response.OutputStream.Write($fileContent, 0, $fileContent.Length)
            $response.StatusCode = 200
            Write-Host "[OK] Servido: $filePath"
        } 
        else {
            $response.StatusCode = 404
            $errorMsg = "404 - Arquivo nao encontrado"
            $errorBytes = [System.Text.Encoding]::UTF8.GetBytes($errorMsg)
            $response.OutputStream.Write($errorBytes, 0, $errorBytes.Length)
            Write-Host "[ERRO] Nao encontrado: $filePath"
        }
        
        $response.OutputStream.Close()
    }
    catch {
        Write-Host "Erro: $_"
    }
}

$listener.Stop()
