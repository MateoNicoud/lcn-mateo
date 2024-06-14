<?php

namespace Tests\Unit;

use App\Models\Article;
use App\Models\User;
use PHPUnit\Framework\TestCase;

class UserTest extends TestCase
{
    /**
     * A basic unit test example.
     *
     * @return void
     */
    public function test_example()
    {
        $this->assertTrue(true);
    }

    public function test_getRouteKeNames()
    {

        $user = User::factory()->create();
        $this->assertEquals('username', $user->getRouteKeyName());
    }

    public function test_articles()
    {


    }


}
