
const { drizzle } = require('drizzle-orm/postgres-js');
const postgres = require('postgres');

const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  console.error('❌ DATABASE_URL não está configurado');
  process.exit(1);
}

const sql = postgres(connectionString, {
  max: 20,
  idle_timeout: 20,
  connect_timeout: 60,
});

async function setupDatabase() {
  try {
    console.log('🔄 Configurando banco de dados...');
    
    // Criar tabela profiles
    await sql`
      CREATE TABLE IF NOT EXISTS profiles (
        id TEXT PRIMARY KEY,
        email TEXT NOT NULL UNIQUE,
        name TEXT NOT NULL,
        user_type TEXT NOT NULL,
        avatar TEXT,
        bio TEXT,
        created_at TIMESTAMP DEFAULT NOW(),
        updated_at TIMESTAMP DEFAULT NOW()
      );
    `;
    console.log('✅ Tabela profiles criada/verificada');
    
    // Criar tabela quizzes
    await sql`
      CREATE TABLE IF NOT EXISTS quizzes (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        subject TEXT NOT NULL,
        description TEXT,
        difficulty_level TEXT NOT NULL,
        time_limit INTEGER DEFAULT 0,
        video_url TEXT,
        video_title TEXT,
        video_thumbnail TEXT,
        video_duration TEXT,
        detected_subject TEXT,
        video_context TEXT,
        questions_generated BOOLEAN DEFAULT false,
        ai_model TEXT,
        created_at TIMESTAMP DEFAULT NOW(),
        updated_at TIMESTAMP DEFAULT NOW()
      );
    `;
    console.log('✅ Tabela quizzes criada/verificada');
    
    // Criar tabela questions
    await sql`
      CREATE TABLE IF NOT EXISTS questions (
        id TEXT PRIMARY KEY,
        quiz_id TEXT REFERENCES quizzes(id) ON DELETE CASCADE NOT NULL,
        question TEXT NOT NULL,
        type TEXT NOT NULL DEFAULT 'multiple-choice',
        options TEXT,
        correct_answer TEXT NOT NULL,
        explanation TEXT,
        difficulty TEXT NOT NULL,
        media_url TEXT,
        media_type TEXT,
        created_at TIMESTAMP DEFAULT NOW()
      );
    `;
    console.log('✅ Tabela questions criada/verificada');
    
    // Criar tabela student_answers
    await sql`
      CREATE TABLE IF NOT EXISTS student_answers (
        id TEXT PRIMARY KEY,
        student_id TEXT NOT NULL,
        quiz_id TEXT REFERENCES quizzes(id) ON DELETE CASCADE NOT NULL,
        question_id TEXT REFERENCES questions(id) ON DELETE CASCADE NOT NULL,
        answer TEXT NOT NULL,
        is_correct BOOLEAN NOT NULL,
        time_spent INTEGER,
        created_at TIMESTAMP DEFAULT NOW()
      );
    `;
    console.log('✅ Tabela student_answers criada/verificada');
    
    // Criar tabela quiz_sessions
    await sql`
      CREATE TABLE IF NOT EXISTS quiz_sessions (
        id TEXT PRIMARY KEY,
        student_id TEXT NOT NULL,
        quiz_id TEXT REFERENCES quizzes(id) ON DELETE CASCADE NOT NULL,
        score REAL DEFAULT 0,
        total_questions INTEGER NOT NULL,
        correct_answers INTEGER DEFAULT 0,
        time_spent INTEGER DEFAULT 0,
        completed_at TIMESTAMP,
        started_at TIMESTAMP DEFAULT NOW()
      );
    `;
    console.log('✅ Tabela quiz_sessions criada/verificada');
    
    // Criar tabela video_processing
    await sql`
      CREATE TABLE IF NOT EXISTS video_processing (
        id TEXT PRIMARY KEY,
        quiz_id TEXT REFERENCES quizzes(id) ON DELETE CASCADE NOT NULL,
        video_url TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'pending',
        progress INTEGER DEFAULT 0,
        error_message TEXT,
        questions_generated INTEGER DEFAULT 0,
        ai_model TEXT,
        created_at TIMESTAMP DEFAULT NOW(),
        updated_at TIMESTAMP DEFAULT NOW()
      );
    `;
    console.log('✅ Tabela video_processing criada/verificada');
    
    console.log('🎉 Banco de dados configurado com sucesso!');
    
  } catch (error) {
    console.error('❌ Erro ao configurar banco:', error);
  } finally {
    await sql.end();
  }
}

setupDatabase();
