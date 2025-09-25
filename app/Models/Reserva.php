<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Reserva
 * 
 * @property int $id_reserva
 * @property int|null $id_cliente
 * @property int|null $id_cancha
 * @property Carbon|null $fecha_inicio
 * @property Carbon|null $fecha_fin
 * @property string|null $estado
 * 
 * @property Cliente|null $cliente
 * @property Cancha|null $cancha
 * @property Collection|Evento[] $eventos
 * @property Collection|Factura[] $facturas
 * @property Collection|Pago[] $pagos
 *
 * @package App\Models
 */
class Reserva extends Model
{
	protected $table = 'reservas';
	protected $primaryKey = 'id_reserva';
	public $timestamps = false;

	protected $casts = [
		'id_cliente' => 'int',
		'id_cancha' => 'int',
		'fecha_inicio' => 'datetime',
		'fecha_fin' => 'datetime'
	];

	protected $fillable = [
		'id_cliente',
		'id_cancha',
		'fecha_inicio',
		'fecha_fin',
		'estado'
	];

	public function cliente()
	{
		return $this->belongsTo(Cliente::class, 'id_cliente');
	}

	public function cancha()
	{
		return $this->belongsTo(Cancha::class, 'id_cancha');
	}

	public function eventos()
	{
		return $this->hasMany(Evento::class, 'id_reserva');
	}

	public function facturas()
	{
		return $this->hasMany(Factura::class, 'id_reserva');
	}

	public function pagos()
	{
		return $this->hasMany(Pago::class, 'id_reserva');
	}
}
