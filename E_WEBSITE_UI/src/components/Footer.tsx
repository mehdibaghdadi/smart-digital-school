import React from 'react';
import { motion } from 'motion/react';
import { BookOpen } from 'lucide-react';
import { Language, translations } from '../translations';

export const Footer = ({ lang }: { lang: Language }) => {
  const t = translations[lang].footer;
  return (
    <footer className="bg-white dark:bg-dark-bg pt-20 pb-10 border-t border-slate-100 dark:border-slate-800 transition-colors">
      <motion.div 
        initial={{ opacity: 0 }}
        whileInView={{ opacity: 1 }}
        viewport={{ once: true }}
        transition={{ duration: 1, ease: "easeOut" }}
        className="max-w-7xl mx-auto px-6"
      >
        <div className="grid md:grid-cols-4 gap-12 mb-20">
          <div className="col-span-2">
            <div className="flex items-center gap-2 mb-8">
              <div className="w-8 h-8  rounded-lg flex items-center justify-center text-white">
                <img src="/logo.png" alt="logo"/>
              </div>
              <span className="text-xl font-bold tracking-tight text-slate-900 dark:text-white">
                Smart<span className="text-brand-600">Digital</span>School
              </span>
            </div>
            <p className="text-slate-500 dark:text-slate-400 max-w-sm mb-8 leading-relaxed">
              {t.desc}
            </p>
            <div className="flex gap-4">
              <a href="https://play.google.com/store/apps/details?id=com.smartdigitalschool.app" className="h-12">
                <img src="https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_Store_badge_EN.svg" alt="Google Play" className="h-full" />
              </a>
            </div>
          </div>
          
          <div>
            <h4 className="font-bold text-slate-900 dark:text-white mb-6">{t.platform}</h4>
            <ul className="space-y-4 text-slate-500 dark:text-slate-400">
              <li><a href="#mission" className="hover:text-brand-600 transition-colors">{translations[lang].nav.presentation}</a></li>
              <li><a href="#solution" className="hover:text-brand-600 transition-colors">{translations[lang].nav.solution}</a></li>
              <li><a href="#how-it-works" className="hover:text-brand-600 transition-colors">{translations[lang].nav.howItWorks}</a></li>
              <li><a href="#pricing" className="hover:text-brand-600 transition-colors">{translations[lang].nav.pricing}</a></li>
            </ul>
          </div>

          <div>
            <h4 className="font-bold text-slate-900 dark:text-white mb-6">{t.legal}</h4>
            <ul className="space-y-4 text-slate-500 dark:text-slate-400">
              <li><a href="https://app.smartdigitalschool.com/privacy" className="hover:text-brand-600 transition-colors">{t.privacy}</a></li>
              <li><a href="https://app.smartdigitalschool.com/terms-conditions" className="hover:text-brand-600 transition-colors">{t.terms}</a></li>
              <li><a href="#contact" className="hover:text-brand-600 transition-colors">{translations[lang].nav.contact}</a></li>
            </ul>
          </div>
        </div>
        
        <div className="pt-10 border-t border-slate-100 dark:border-slate-800 flex flex-col md:flex-row justify-between items-center gap-6">
          <p className="text-slate-400 text-sm">
            © 2021-2026 Smart Digital School. {t.rights}
          </p>
          <p className="text-slate-400 text-sm flex items-center gap-1">
            {t.powered} <a href="https://eware.ma" className="font-bold text-slate-600 dark:text-slate-300 hover:text-brand-600">E-WARE</a>
          </p>
        </div>
      </motion.div>
    </footer>
  );
};
