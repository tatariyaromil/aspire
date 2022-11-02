<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Admin;
use App\Models\User;
class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Admin::create([
            'name' => 'Admin',
            'email' => 'admin@admin.com',
            'username' => 'haresh',
            'password' => bcrypt('Admin@123#')
        ]);

        User::create([
            'name' => 'Romil Tatariya',
            'email' => 'tatariyaromil@gmail.com',
            'password' => bcrypt('123456')
        ]);
    }
}
