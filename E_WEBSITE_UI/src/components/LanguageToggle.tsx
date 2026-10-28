import React from 'react';
import { Language } from '../translations';

interface LanguageToggleProps {
  currentLang: Language;
  setLang: (lang: Language) => void;
}

export const LanguageToggle: React.FC<LanguageToggleProps> = ({ currentLang, setLang }) => {
  const langs: { code: Language; label: string }[] = [
    { code: 'fr', label: 'FR' },
    { code: 'en', label: 'EN' },
    { code: 'es', label: 'ES' },
  ];

  return (
    <div className="flex items-center gap-1 bg-slate-100 dark:bg-slate-800 p-1 rounded-xl">
      {langs.map((lang) => (
        <button
          key={lang.code}
          onClick={() => setLang(lang.code)}
          className={`px-2 py-1 text-xs font-bold rounded-lg transition-all ${
            currentLang === lang.code
              ? 'bg-white dark:bg-slate-700 text-brand-600 shadow-sm'
              : 'text-slate-500 hover:text-slate-700 dark:hover:text-slate-300'
          }`}
        >
          {lang.label}
        </button>
      ))}
    </div>
  );
};
