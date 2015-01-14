#!/usr/bin/env ruby


load 'funciones_cifrado_hill.rb'

#abecedario = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
abecedario = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n", "ñ","o","p","q","r","s","t","u","v","w","x","y","z", " ", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]


if __FILE__ == $0
	begin
		opcion = menu()
	end while opcion != 'c' and opcion != 'd'

	matriz = crearMatriz()

	determinante = matriz.determinant

	resultado = mcd(determinante, 38)

	if (resultado == 1) then
		if opcion == 'c' then
			puts "Escriba el mensaje a cifrar:\n"
			msn = STDIN.gets.chomp
			mensaje = msn.to_s

			if (mensaje.length()%2 == 0) then
				numCols = mensaje.length()/2
			else
				mensaje = mensaje + "x"
				numCols = mensaje.length()/2
			end

			matrizTexto = matrizDeArray(2, numCols, mensaje)

			# Cifrando el texto
			matrizEncriptada = Array.new
			matrizMultiplica = Matrix[]
			for i in 0..numCols-1
				matrizColumna = Matrix[]
				matrizColumna = extraerColumna(matrizTexto, i)
				matrizMultiplica = matriz*matrizColumna
				# Se aplica el modulo en el cifrado
				matrizEncriptada << matrizMultiplica[0,0]%38
				matrizEncriptada << matrizMultiplica[1,0]%38
			end

			# Se pasa a caracter en una cadena
			matrizEncriptadaCaracter = ""
			matrizEncriptada.each { |a| matrizEncriptadaCaracter = matrizEncriptadaCaracter + abecedario[a] }

			puts "Mensaje cifrado: #{matrizEncriptadaCaracter}"
		else
			puts "Escriba el mensaje a descifrar:\n"
			msn = STDIN.gets.chomp
			mensaje = msn.to_s

			matrizInversa = matriz.inverse()
			matrizInversaModulo = inversaModulo(matrizInversa)
			numCols = mensaje.length()/2

			matrizTextoEncriptado = matrizDeArray(2, numCols, mensaje)

			# Descrifrando el texto
			matrizDescifrada = Array.new
			matrizMultiplica = Matrix[]
			for i in 0..numCols-1
				matrizColumna = Matrix[]
				matrizColumna = extraerColumna(matrizTextoEncriptado, i)
				matrizMultiplica = matrizInversaModulo*matrizColumna
				# Se aplica el modulo en el descifrado
				matrizDescifrada << matrizMultiplica[0,0]%38
				matrizDescifrada << matrizMultiplica[1,0]%38
			end

			# Se pasa a caracter en una cadena
			matrizDescifradaCaracter = ""
			matrizDescifrada.each { |a| matrizDescifradaCaracter = matrizDescifradaCaracter + abecedario[a] }

			puts "Mensaje descifrado: #{matrizDescifradaCaracter}"
		end
	else
		puts "Esta matriz no tiene inversa para su descifrado. Fin de la ejecución"
	end

end
