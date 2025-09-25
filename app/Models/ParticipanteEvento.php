<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class ParticipanteEvento
 * 
 * @property int $id_par_evento
 * @property int|null $id_evento
 * @property int|null $id_cliente
 * 
 * @property Evento|null $evento
 * @property Cliente|null $cliente
 *
 * @package App\Models
 */
class ParticipanteEvento extends Model
{
	protected $table = 'participante_evento';
	protected $primaryKey = 'id_par_evento';
	public $timestamps = false;

	protected $casts = [
		'id_evento' => 'int',
		'id_cliente' => 'int'
	];

	protected $fillable = [
		'id_evento',
		'id_cliente'
	];

	public function evento()
	{
		return $this->belongsTo(Evento::class, 'id_evento');
	}

	public function cliente()
	{
		return $this->belongsTo(Cliente::class, 'id_cliente');
	}
}
