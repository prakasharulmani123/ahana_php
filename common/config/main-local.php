<?php
if (strpos($_SERVER['SERVER_NAME'], 'localhost') !== false || strpos($_SERVER['SERVER_NAME'], 'ahana.local') !== false) {
    $host = 'localhost';
    $db_user = 'root';
    $db_pass = '';
    $db_name = 'ahana';
} elseif (strpos($_SERVER['SERVER_NAME'], 'demo.arkinfotec.in') !== false) {
    $host = 'localhost';
    $db_user = 'rajencba_ahana';
    $db_pass = 's6(Srsh7_qQL';
    $db_name = 'rajencba_ahanademo';
}

return [
    'components' => [
        'db' => [
            'class' => 'yii\db\Connection',
            'dsn' => "mysql:host={$host};dbname={$db_name}",
            'username' => $db_user,
            'password' => $db_pass,
            'charset' => 'utf8',
        ],
        'mailer' => [
            'class' => 'yii\swiftmailer\Mailer',
            'viewPath' => '@common/mail',
            // send all mails to a file by default. You have to set
            // 'useFileTransport' to false and configure a transport
            // for the mailer to send real emails.
            'useFileTransport' => true,
        ],
    ],
];
