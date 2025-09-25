<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Cliente
 * 
 * @property int $id_cliente
 * @property string|null $nombre
 * @property string|null $correo
 * @property string|null $contraseña
 * @property string|null $telefono
 * @property int|null $id_rol
 * 
 * @property Rol|null $rol
 * @property Collection|Cancha[] $canchas
 * @property Collection|Factura[] $facturas
 * @property Collection|ParticipanteEvento[] $participante_eventos
 * @property Collection|Reserva[] $reservas
 *
 * @package App\Models
 */
class Cliente extends Model
{
	protected $table = 'clientes';
	protected $primaryKey = 'id_cliente';
	public $timestamps = false;

	protected $casts = [
		'id_rol' => 'int'
	];

	protected $fillable = [
		'nombre',
		'correo',
		'contraseña',
		'telefono',
		'id_rol'
	];

	public function rol()
	{
		return $this->belongsTo(Rol::class, 'id_rol');
	}

	public function canchas()
	{
		return $this->hasMany(Cancha::class, 'id_admin_cancha');
	}

	public function facturas()
	{
		return $this->hasMany(Factura::class, 'id_cliente');
	}

	public function participante_eventos()
	{
		return $this->hasMany(ParticipanteEvento::class, 'id_cliente');
	}

	public function reservas()
	{
		return $this->hasMany(Reserva::class, 'id_cliente');
	}
}
