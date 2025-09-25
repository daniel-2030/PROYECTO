<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Factura
 * 
 * @property int $id_factura
 * @property int|null $id_pago
 * @property int|null $id_cliente
 * @property int|null $id_reserva
 * @property int|null $id_cancha
 * @property Carbon|null $fecha_emision
 * @property float|null $total
 * 
 * @property Pago|null $pago
 * @property Cliente|null $cliente
 * @property Reserva|null $reserva
 * @property Cancha|null $cancha
 *
 * @package App\Models
 */
class Factura extends Model
{
	protected $table = 'factura';
	protected $primaryKey = 'id_factura';
	public $timestamps = false;

	protected $casts = [
		'id_pago' => 'int',
		'id_cliente' => 'int',
		'id_reserva' => 'int',
		'id_cancha' => 'int',
		'fecha_emision' => 'datetime',
		'total' => 'float'
	];

	protected $fillable = [
		'id_pago',
		'id_cliente',
		'id_reserva',
		'id_cancha',
		'fecha_emision',
		'total'
	];

	public function pago()
	{
		return $this->belongsTo(Pago::class, 'id_pago');
	}

	public function cliente()
	{
		return $this->belongsTo(Cliente::class, 'id_cliente');
	}

	public function reserva()
	{
		return $this->belongsTo(Reserva::class, 'id_reserva');
	}

	public function cancha()
	{
		return $this->belongsTo(Cancha::class, 'id_cancha');
	}
}
