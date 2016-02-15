<?php
$client = ['class' => 'yii\db\Connection', 'charset' => 'utf8'];
if (defined('DOMAIN_PATH')) {
    if (isset(Yii::$app->session['client']) && isset(Yii::$app->session['current_domain_path']) && Yii::$app->session['current_domain_path'] == DOMAIN_PATH) {
        $client = Yii::$app->session['client'];
    } else {
        $main = require_once(__DIR__ . '/main-local.php');

        $db = $main['components']['db'];
        $dbh = new PDO($db['dsn'], $db['username'], $db['password']);

        $sql = 'SELECT * FROM co_organization WHERE org_domain = :domain';
        $sth = $dbh->prepare($sql);
        $sth->execute(array(':domain' => DOMAIN_PATH));
        $read = $sth->fetch(PDO::FETCH_OBJ);

        $client['dsn'] = "mysql:host={$read->org_db_host};dbname={$read->org_database}";
        $client['username'] = "{$read->org_db_username}";
        $client['password'] = "{$read->org_db_password}";

        Yii::$app->session['client'] = $client;
        Yii::$app->session['current_domain_path'] = DOMAIN_PATH;
    }
}

return [
    'vendorPath' => dirname(dirname(__DIR__)) . '/vendor',
    'components' => [
        'cache' => [
            'class' => 'yii\caching\FileCache',
        ],
        'client' => $client,
    ],
];
