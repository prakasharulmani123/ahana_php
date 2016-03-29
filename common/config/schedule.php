<?php

mail('prakash.paramanandam@arkinfotec.com', 'Cron', 'HI');
echo 'hi';
exit;
    
use common\models\CoOrganization;
use omnilight\scheduling\Schedule;
use yii\console\Application;
/**
 * @var Schedule $schedule
 */

// Place here all of your cron jobs

//// This command will execute ls command every five minutes
//$schedule->exec('ls')->everyFiveMinutes();
//
//// This command will execute migration command of your application every hour
//$schedule->command('migrate')->hourly();
//
//// This command will call callback function every day at 10:00
//$schedule->call(function(Application $app) {
//    // Some code here...
//})->dailyAt('10:00');

// This command will call callback function every minute
$schedule->call(function(Application $app) {
    // Some code here...
//    $schedule->command('foo')->emailOutputTo('prakash.paramanandam@arkinfotec.com');
    
    mail('prakash.paramanandam@arkinfotec.com', 'Cron', date('Y-m-d H:i:s'));
//    $organizations = CoOrganization::find()->all();
//    foreach ($organizations as $key => $organization) {
//        $organization->attributes = [
//            'modified_by' => -2
//        ];
//        $organization->save(false);
//    }
})->everyMinute();
?>