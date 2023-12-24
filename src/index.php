<?php
$server = new \OpenSwoole\HTTP\Server("0.0.0.0", 8080);
$server->set([
  'worker_num' => 4,      // The number of worker processes to start
  'task_worker_num' => 4, // The amount of task workers to start
  'backlog' => 128,       // TCP backlog connection number
]);

// Triggered when new worker processes starts
$server->on("WorkerStart", function($server, $workerId)
{
    // ...
});

// Triggered when the HTTP Server starts, connections are accepted after this callback is executed
$server->on("Start", function($server, $workerId)
{
    // ...
});

// The main HTTP server request callback event, entry point for all incoming HTTP requests
$server->on('Request', function(\OpenSwoole\Server\Request $request, \OpenSwoole\Server\Response $response)
{
    $response->end('<h1>Hello World!</h1>');
});

// Triggered when the server is shutting down
$server->on("Shutdown", function($server, $workerId)
{
    // ...
});

// Triggered when worker processes are being stopped
$server->on("WorkerStop", function($server, $workerId)
{
    // ...
});

$server->start();
