<?php
header('Content-Type: application/json');
$input = json_decode(file_get_contents("php://input"), true);
$sql = $input["sql"] ?? "";
$esperado = strtolower(trim($input["expected"] ?? ""));

$host = "localhost";
$user = "root";
$pass = "";
$db = "misterio";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    echo json_encode(["ok" => false, "feedback" => "Erro na conexão.", "resultado" => ""]);
    exit;
}

// Bloquear comandos perigosos
if (stripos($sql, "drop") !== false || stripos($sql, "alter") !== false) {
    echo json_encode(["ok" => false, "feedback" => "Comando não permitido.", "resultado" => ""]);
    exit;
}

$sqlLimpo = strtolower(trim($sql));
$ok = ($sqlLimpo === $esperado);
$feedback = $ok ? "✅ Correto! Muito bem." : "❌ Tente novamente. Veja a descrição da lição.";

$resultado = "";

// Verificar se é um comando que modifica dados (INSERT, UPDATE, DELETE)
$isModifyingCommand = stripos($sql, "insert") !== false || 
                     stripos($sql, "update") !== false || 
                     stripos($sql, "delete") !== false;

if ($isModifyingCommand) {
    // Para comandos que modificam dados, apenas validar sem executar
    if ($ok) {
        $resultado = "Comando validado com sucesso! (Não executado para preservar os dados do jogo)";
    } else {
        $resultado = "Comando incorreto. Verifique a sintaxe.";
    }
} else {
    // Para comandos SELECT, executar normalmente
    if ($result = $conn->query($sql)) {
        if ($result === true) {
            $resultado = "Comando executado com sucesso.";
        } elseif ($result->num_rows > 0) {
            $columns = array_keys($result->fetch_assoc());
            $resultado .= implode("\t", $columns) . "\n";
            $result->data_seek(0);
            while ($row = $result->fetch_assoc()) {
                $resultado .= implode("\t", $row) . "\n";
            }
        } else {
            $resultado = "Nenhum resultado encontrado.";
        }
    } else {
        $resultado = "Erro: " . $conn->error;
    }
}

echo json_encode(["ok" => $ok, "feedback" => $feedback, "resultado" => $resultado]);
$conn->close();
?>