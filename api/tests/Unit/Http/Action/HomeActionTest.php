<?php

namespace Api\Test\Unit\Http\Action;

use Api\Http\Action\HomeAction;
use Laminas\Diactoros\ServerRequest;
use PHPUnit\Framework\TestCase;

class HomeActionTest extends TestCase
{
    public function testSuccess(): void
    {
        $action = new HomeAction();

        $response = $action->handle(new ServerRequest());

        self::assertEquals(200, $response->getStatusCode());
        self::assertJson($content = $response->getBody()->getContents());

        $data = json_decode($content, true);

        self::assertEquals([
            'name' => 'App API',
            'version' => '1.0',
        ], $data);
    }
}
