#!/usr/bin/env ruby

require 'matrix'



def menu
	puts "(c) Cifrar"
	puts "(d) Descifrar"
	puts "Elige opción"
	opt = STDIN.gets.chomp
	opcion = opt.to_s
	return opcion
end

def crearMatriz
	puts "crear matriz 2x2\n"
	puts "elemento [0][0]\n"
	elem11 = STDIN.gets.chomp
	elemento11 = elem11.to_i
	puts "elemento [0][1]\n"
	elem12 = STDIN.gets.chomp
	elemento12 = elem12.to_i
	puts "elemento [1][0]\n"
	elem21 = STDIN.gets.chomp
	elemento21 = elem21.to_i
	puts "elemento [1][1]\n"
	elem22 = STDIN.gets.chomp
	elemento22 = elem22.to_i

	matriz = Matrix.rows([[elemento11, elemento12], [elemento21, elemento22]])
	return matriz
end

def matrizDeArray(filas, columnas, mensaje)
	abecedario = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n", "ñ","o","p","q","r","s","t","u","v","w","x","y","z", " ", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
# http://www.ruby-doc.org/core-2.2.0/Array.html
	matriz = Array.new(filas) { Array.new(columnas) }
	k = 0
	for i in 0..columnas-1
		for j in 0..filas-1
# https://stackoverflow.com/questions/308749/whats-the-opposite-of-chr-in-ruby
			#matriz[j][i]=mensaje[k].ord	# "ord" pasa a numeros los caracteres y "chr" los pasamos a caracter los numeros
			matriz[j][i] = abecedario.index(mensaje[k])
			k = k + 1
		end
	end

	m = Matrix[]

	for i in 0..filas-1
# https://stackoverflow.com/questions/16011252/add-a-row-array-to-an-empty-matrix
		m = Matrix.rows(m.to_a << matriz[i])
	end

	return m
end

def inversaModulo(matrizInversa)
	modulo = Matrix.rows([[matrizInversa[0,0].to_i, matrizInversa[0,1].to_i], [matrizInversa[1,0].to_i, matrizInversa[1,1].to_i]])
	return modulo
end

def extraerColumna(matrizTexto, columna)
	nuevaMatriz = Matrix[] #Se crea una nueva matrix
	nuevaMatriz = Matrix.rows(nuevaMatriz.to_a << matrizTexto.column(columna).to_a).transpose #Se extrae la columna correspondiente para la operación de encriptación y directamente se hace su traspuesta
	return nuevaMatriz
end

def mcd(num1, num2)
	absolutos = num1.abs, num2.abs
	if (absolutos.min == 0) then
		return absolutos.max
	else
		if (absolutos.max%absolutos.min == 0) then
			return absolutos.min
		else
			return mcd(absolutos.min, absolutos.max%absolutos.min)
		end
	end
end
