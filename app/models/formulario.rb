class Formulario < ActiveRecord::Base
  attr_accessible :codigo, :url, :nombre, :tipo

  validates :codigo, :url, :nombre, :tipo, :presence => true

  def estado(curso)
  	return FormularioCurso.where(:formulario_id => self, :curso_id => curso).first.estado
  end

  def contestado?(curso)
    formulario_curso = FormularioCurso.where(:formulario_id => self, :curso_id => curso).first
    return formulario_curso.contestado?
  end

  def pendientes(curso)
    formulario_curso =  FormularioCurso.where(:formulario_id => self, :curso_id => curso).first
    return formulario_curso.pendientes
  end

  def contestados(curso)
    formulario_curso =  FormularioCurso.where(:formulario_id => self, :curso_id => curso).first
    unless formulario_curso.nil?
      return formulario_curso.contestados
    else
      return 0
    end
  end

  def contestados
    contador = 0
      FormularioCurso.where(:formulario_id => self).all.each do |formulario_curso|
        unless formulario_curso.nil?
          if formulario_curso.contestado?
            contador = contador +  1
          end
        end
      end
    return contador
  end

  def pendientes
    contador = 0
      FormularioCurso.where(:formulario_id => self).all.each do |formulario_curso|
        unless formulario_curso.nil?
          if formulario_curso.pendiente?
            contador = contador +  1
          end
        end
      end
    return contador
  end

  def no_asignados
    cursos = Curso.all.count
    return cursos - self.contestados - self.pendientes
  end

  def cursos_ids
    cursos = Array.new
    curso_ids = FormularioCurso.where(:formulario_id => self).select(:curso_id).group(:curso_id).collect{|p| p.curso_id}
    curso_ids.each do |curso_id|
      cursos.push curso_id
    end
    return cursos
  end

  def cursos
    cursos = Array.new
    curso_ids = FormularioCurso.where(:formulario_id => self).select(:curso_id).group(:curso_id).collect{|p| p.curso_id}
    curso_ids.each do |curso_id|
      cursos.push Curso.find(curso_id)
    end
    return cursos
  end

  def eliminar_cursos
    curso_ids = FormularioCurso.where(:formulario_id => self).select(:curso_id).group(:curso_id).collect{|p| p.curso_id}
    curso_ids.each do |curso_id|
      FormularioCurso.where(:formulario_id => self, :curso_id => curso_id).destroy_all
    end
  end

  def duplicates(curso_id)
    unless FormularioCurso.where(:formulario_id => self, :curso_id => curso_id).first.nil?
      return FormularioCurso.where(:formulario_id => self, :curso_id => curso_id).first.duplicates
    else
      return 1
    end
  end

  def eliminar_curso(curso_id)
    FormularioCurso.where(:formulario_id => self, :curso_id => curso_id).destroy_all
  end
end
