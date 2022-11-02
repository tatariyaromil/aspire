<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('loans', function (Blueprint $table) {
            $table->id();
            $table->integer('user_id');
            $table->float('amount', 8, 2);
            $table->integer('term');
            $table->float('term_amount', 8, 2);
            $table->date('date');
            $table->enum('request_status', ['Pending', 'Approved', 'Rejected'])->default('Pending');
            $table->enum('loan_status', ['Paid', 'Unpaid'])->default('Unpaid');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('loans');
    }
};
