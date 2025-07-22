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

if (stripos($sql, "drop") !== false || stripos($sql, "alter") !== false) {
    echo json_encode(["ok" => false, "feedback" => "Comando não permitido.", "resultado" => ""]);
    exit;
}

$sqlLimpo = strtolower(trim($sql));

// Simula o INSERT apenas na lição 7 (antes de executar qualquer query)
if ($esperado === "insert into pessoas (nome, idade, profissao, suspeito) values ('lucas alves', 25, 'estudante', 0);") {
    echo json_encode([
        "ok" => ($sqlLimpo === $esperado),
        "feedback" => ($sqlLimpo === $esperado) ? "✅ Correto! Muito bem." : "❌ Tente novamente. Veja a descrição da lição.",
        "resultado" => "Comando executado com sucesso."
    ]);
    $conn->close();
    exit;
}

$ok = ($sqlLimpo === $esperado);
$feedback = $ok ? "✅ Correto! Muito bem." : "❌ Tente novamente. Veja a descrição da lição.";

$resultado = "";
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

echo json_encode(["ok" => $ok, "feedback" => $feedback, "resultado" => $resultado]);
$conn->close();
?>