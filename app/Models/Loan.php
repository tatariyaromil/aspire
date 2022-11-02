<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Loan extends Model
{
    use HasFactory;

    public function loanTerm(){
        return $this->hasMany(LoanTerm::class);
    }

    public function estimatedLoanTerm(){
        return $this->hasMany(EstimatedLoanTerm::class);
    }
}
